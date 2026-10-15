///
/// FeatureHub: Usage based edge. This service holds an update interval
/// which can be overridden by the server. It requests state by calling the
/// GET api if the interval has expired.
///
/// This concept is based on the same one from the Dart API and is intended for Mobile usage.
///

import Foundation
import CryptoKit

internal protocol FeatureRequestor {
  func getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?, header: String?) async -> Response<[FeatureEnvironmentCollection]>?
}

// Swift's substring handling is an absolute travesty, this from Stack Overflow makes it palatable
extension String {
  func index(from: Int) -> Index {
    self.index(startIndex, offsetBy: from)
  }

  func substring(from: Int) -> String {
    let fromIndex = index(from: from)
    return String(self[fromIndex...])
  }
}

internal struct DefaultFeatureRequestor: FeatureRequestor {
  // kept here rather than in the global OpenAPIClientAPI.basePath, which is shared by every
  // config in the app
  let _baseUrl: String

  public init(_ baseUrl: String) {
    _baseUrl = baseUrl
  }

  // the same request FeatureServiceAPI.getFeatureStatesWithRequestBuilder makes, but against our base url
  private func requestBuilder(apiKeys: [String], contextSha: String?) -> RequestBuilder<[FeatureEnvironmentCollection]> {
    let urlString = _baseUrl + "/features/"

    var urlComponents = URLComponents(string: urlString)
    urlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
      "apiKey": (wrappedValue: apiKeys.encodeToJSON(), isExplode: true),
      "contextSha": (wrappedValue: contextSha?.encodeToJSON(), isExplode: true),
    ])

    let builder: RequestBuilder<[FeatureEnvironmentCollection]>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

    return builder.init(method: "GET", URLString: (urlComponents?.string ?? urlString),
      parameters: nil, headers: [:], requiresAuthentication: false)
  }

  func getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?, header: String?) async -> Response<[FeatureEnvironmentCollection]>? {
    let reqBuilder = requestBuilder(apiKeys: apiKeys, contextSha: contextSha)

    // these belong to this request (and this edge) only, so they don't go in the global
    // OpenAPIClientAPI.customHeaders, which is shared by every config in the app
    if let etag = etag {
      reqBuilder.addHeaders(["if-none-match": etag])
    }

    if let header = header {
      reqBuilder.addHeaders(["x-featurehub": header])
    }

    return try? await reqBuilder.execute()
  }
}

internal class UseBasedEdge: EdgeService {
  // poll() can be called from several tasks at once (the config, each context's used() and
  // context_change), so every access to the state below is serialised. The lock is never held
  // across an await or while calling into the repository.
  private let lock = NSRecursiveLock()
  let _repo: InternalFeatureRepository
  let _config: FeatureHubConfig
  let _requestor: FeatureRequestor
  var _timeoutInSeconds: Double
  var _initialized: Bool = false
  var _stopped: Bool = false
  var _header: String?
  var _cacheTimeout: Date
  var _contextSha: String = "0"
  var _callActive: Bool = false
  var _etag: String? = nil
  // bumped on every context change so we can tell when a response is for an old context
  private var _contextGeneration: Int = 0

  public init(_ repo: InternalFeatureRepository, _ config: FeatureHubConfig, _ timeoutInSeconds: Int?,
              requestor: FeatureRequestor? = nil) {
    _repo = repo
    _config = config
    _timeoutInSeconds = Double(timeoutInSeconds ?? 300)
    _cacheTimeout = Date() - _timeoutInSeconds - 1  // ensure the cache is already timed out
    _requestor = requestor ?? DefaultFeatureRequestor(config.baseUrl)
  }

  private func withLock<T>(_ block: () -> T) -> T {
    lock.lock()
    defer { lock.unlock() }
    return block()
  }

  var canStart: Bool {
    get {
      withLock { !_stopped }
    }
  }

  internal func ensureCacheExpired() {
    withLock {
      _initialized = true
      _cacheTimeout = Date() - _timeoutInSeconds - 1
    }
  }

  internal func ensureCacheNotExpired() {
    withLock {
      _initialized = true
      _cacheTimeout = Date() + (_timeoutInSeconds/2)
    }
  }

  internal var timeoutInSeconds: Double {
    get {
      withLock { _timeoutInSeconds }
    }
  }

  internal var etag: String? {
    get  {
      withLock { _etag }
    }

    set {
      withLock { _etag = newValue }
    }
  }

  // decides whether we should make a request and if so claims it, returning what to send
  private func startPoll() -> (contextSha: String, etag: String?, header: String?, generation: Int)? {
    withLock {
      // they set the timeout to zero, so we don't ask again
      if (_initialized && _timeoutInSeconds == 0) {
        return nil
      }

      // if the cache timeout < current date, then it will be order ascending and we should poll
      if _stopped || _callActive || (_initialized && (_cacheTimeout.compare(Date()) != ComparisonResult.orderedAscending)) {
        return nil
      }

      _initialized = true
      _callActive = true

      return (_contextSha, _etag, _header, _contextGeneration)
    }
  }

  func poll() async {
    guard let request = startPoll() else {
      return
    }

    logger.trace("Starting REST request for \(_config.baseUrl) - contextSha is \(request.contextSha), etag \(String(describing: request.etag))")

    let response = await _requestor.getFeatureStates(apiKeys: _config.apiKeys, contextSha: request.contextSha,
      etag: request.etag, header: request.header)

    let result: ProcessedResult? = withLock {
      // the context changed while we were waiting, so these features are for the old context and
      // the request made for the new one (which now owns _callActive) will bring the right ones
      if request.generation != _contextGeneration {
        logger.trace("context changed during REST request, ignoring result")
        return nil
      }

      defer {
        _callActive = false

        if !_stopped {
          calculateNextTimerPeriod()
        }
      }

      return response.map { process($0) }
    }

    if let result = result {
      apply(result)
    }
  }

  // what the repository needs to be told about the result of a request
  private enum ProcessedResult {
    case nothing
    case failure
    case features([FeatureState])
    case empty
  }

  // callers must hold the lock
  private func process(_ val: Response<[FeatureEnvironmentCollection]>) -> ProcessedResult {
    logger.trace("REST status is \(val.statusCode)")

    if (val.statusCode == 200) || (val.statusCode == 236) {
      if let etagHeader = val.header["etag"] {
        _etag = etagHeader
      }

      if let cacheControl = val.header["cache-control"] {
        determineAlternativeTimeoutInterval(cacheControl)
      }

      if (val.statusCode == 236) {
        _stopped = true
      }

      return processResult(val.body)
    } else if (val.statusCode == 400 || val.statusCode == 404) {
      _stopped = true
      return .failure
    }

    return .nothing
  }

  // called without the lock as the repository has its own
  private func apply(_ result: ProcessedResult) {
    switch result {
    case .nothing:
      break
    case .failure:
      _repo.notify(status: SSEResultState.failure)
    case .features(let features):
      _repo.updateFeatures(features)
    case .empty:
      _repo.empty()
    }
  }

  // proper regex doesn't  turn up until Ventura, which is just insane
  private func matches(for regex: String, in text: String) -> [String] {

    do {
      let regex = try NSRegularExpression(pattern: regex)
      let results = regex.matches(in: text,
        range: NSRange(text.startIndex..., in: text))
      return results.map {
        String(text[Range($0.range, in: text)!])
      }
    } catch {
      return []
    }
  }

  private func determineAlternativeTimeoutInterval(_ cacheHeader: String) {
    let search = matches(for: "max-age=(\\d+)", in: cacheHeader)
    if !search.isEmpty {
      let cacheAge = search[0].substring(from: 8)
      let age = Double(cacheAge) ?? _timeoutInSeconds

      if age > 0 {
        _timeoutInSeconds = age
      }
    }
  }

  private func calculateNextTimerPeriod() {
    _cacheTimeout = Date() + _timeoutInSeconds
  }

  private func processResult(_ environments: [FeatureEnvironmentCollection]?) -> ProcessedResult {
    if environments != nil {
      let allFeatures: [FeatureState] = environments!.map({ $0.features }).compactMap({ $0 }).flatMap({ $0 })

      if allFeatures.count > 0 {
        return .features(allFeatures)
      } else {
        return .empty
      }
    }

    return .nothing
  }

  func context_change(_ newHeader: String) async {
    let changed: Bool = withLock {
      if (newHeader != _header && !_stopped) {
        // the header is sent with each request by poll()
        if !newHeader.isEmpty {
          _header = newHeader
          _contextSha = SHA256.hash(data: Data(newHeader.utf8)).compactMap { String(format: "%02x", $0) }.joined()
        } else {
          _header = nil
          _contextSha = "0"
        }

        // override  the  call active to allow for a second inflight request
        _callActive = false
        _contextGeneration += 1
        _initialized = true
        // force a poll to happen as the header changed so the state will have changed
        _cacheTimeout = Date() - _timeoutInSeconds - 1

        return true
      }

      return false
    }

    if changed {
      await poll()
    }
  }

  func close() {
    withLock {
      _stopped = true
    }
  }
}
