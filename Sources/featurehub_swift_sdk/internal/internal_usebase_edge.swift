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

// the generated client builds the request against the global OpenAPIClientAPI.basePath and merges
// the global OpenAPIClientAPI.customHeaders over the request's own headers. Both are shared by every
// config in the app, so we send the generated request to our own server and let our headers win.
internal final class FeatureHubRequestBuilder<T: Decodable>: URLSessionDecodableRequestBuilder<T> {
  override func buildHeaders() -> [String: String] {
    var httpHeaders = super.buildHeaders()
    for (key, value) in headers {
      httpHeaders[key] = value
    }
    return httpHeaders
  }
}

internal struct DefaultFeatureRequestor: FeatureRequestor {
  // the server root, without any trailing slash
  let _baseUrl: String

  public init(_ baseUrl: String) {
    var url = baseUrl
    while url.hasSuffix("/") {
      url.removeLast()
    }
    _baseUrl = url
  }

  internal func requestBuilder(apiKeys: [String], contextSha: String?, etag: String?, header: String?) -> RequestBuilder<[FeatureEnvironmentCollection]> {
    // let the generated client work out the path and query, so we follow it when it is regenerated
    let generated = FeatureServiceAPI.getFeatureStatesWithRequestBuilder(apiKey: apiKeys, contextSha: contextSha)

    var urlString = generated.URLString
    if urlString.hasPrefix(OpenAPIClientAPI.basePath) {
      urlString = _baseUrl + urlString.dropFirst(OpenAPIClientAPI.basePath.count)
    }

    let reqBuilder = FeatureHubRequestBuilder<[FeatureEnvironmentCollection]>(method: generated.method, URLString: urlString,
      parameters: generated.parameters, headers: generated.headers, requiresAuthentication: generated.requiresAuthentication)

    // these belong to this request (and this edge) only
    if let etag = etag {
      reqBuilder.addHeaders(["if-none-match": etag])
    }

    if let header = header {
      reqBuilder.addHeaders(["x-featurehub": header])
    }

    return reqBuilder
  }

  func getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?, header: String?) async -> Response<[FeatureEnvironmentCollection]>? {
    let reqBuilder = requestBuilder(apiKeys: apiKeys, contextSha: contextSha, etag: etag, header: header)

    do {
      return try await reqBuilder.execute()
    } catch {
      return DefaultFeatureRequestor.response(from: error)
    }
  }

  // the generated client throws for anything other than a 2xx, but the edge needs to see a 304 (not
  // modified) or a 400/404 (bad api keys) so it can act on them. Anything without a status, such as
  // the network being unavailable, has no response.
  internal static func response(from error: Error) -> Response<[FeatureEnvironmentCollection]>? {
    guard case ErrorResponse.error(let statusCode, let data, let response, _) = error, statusCode > 0 else {
      return nil
    }

    if let httpResponse = response as? HTTPURLResponse {
      return Response(response: httpResponse, body: [], bodyData: data)
    }

    return Response(statusCode: statusCode, header: [:], body: [], bodyData: data)
  }
}

// an edge that wants to know as soon as a context change is on its way, before it is sent
internal protocol ContextChangeAware {
  func contextChangeQueued()
}

internal class UseBasedEdge: EdgeService, ContextChangeAware {
  // poll() can be called from several tasks at once (the config, each context's used() and
  // context_change), so every access to the state below is serialised. The lock is never held
  // across an await.
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
  // bumped whenever the context is changing, so we can tell when a response is for an old context
  private var _contextGeneration: Int = 0
  // context changes that have been queued but haven't reached context_change yet
  private var _pendingContextChanges: Int = 0
  // the request that currently owns _callActive
  private var _requestCount: Int = 0
  private var _activeRequest: Int?

  public init(_ repo: InternalFeatureRepository, _ config: FeatureHubConfig, _ timeoutInSeconds: Int?,
              requestor: FeatureRequestor? = nil) {
    _repo = repo
    _config = config
    _timeoutInSeconds = Double(timeoutInSeconds ?? 300)
    _cacheTimeout = Date() - _timeoutInSeconds - 1  // ensure the cache is already timed out
    _requestor = requestor ?? DefaultFeatureRequestor(config.baseUrl)
  }

  var canStart: Bool {
    get {
      lock.synchronized { !_stopped }
    }
  }

  internal func ensureCacheExpired() {
    lock.synchronized {
      _initialized = true
      _cacheTimeout = Date() - _timeoutInSeconds - 1
    }
  }

  internal func ensureCacheNotExpired() {
    lock.synchronized {
      _initialized = true
      _cacheTimeout = Date() + (_timeoutInSeconds/2)
    }
  }

  internal var timeoutInSeconds: Double {
    get {
      lock.synchronized { _timeoutInSeconds }
    }
  }

  internal var etag: String? {
    get  {
      lock.synchronized { _etag }
    }

    set {
      lock.synchronized { _etag = newValue }
    }
  }

  private struct PollRequest {
    let id: Int
    let generation: Int
    let contextSha: String
    let etag: String?
    let header: String?
  }

  // callers must hold the lock
  private func claimRequest() -> PollRequest {
    _initialized = true
    _callActive = true
    _requestCount += 1
    _activeRequest = _requestCount

    return PollRequest(id: _requestCount, generation: _contextGeneration, contextSha: _contextSha, etag: _etag, header: _header)
  }

  // decides whether we should make a request and if so claims it
  private func startPoll() -> PollRequest? {
    lock.synchronized {
      // they set the timeout to zero, so we don't ask again
      if (_initialized && _timeoutInSeconds == 0) {
        return nil
      }

      // the context is about to change, so its request is the one worth making
      if _pendingContextChanges > 0 {
        return nil
      }

      // if the cache timeout < current date, then it will be order ascending and we should poll
      if _stopped || _callActive || (_initialized && (_cacheTimeout.compare(Date()) != ComparisonResult.orderedAscending)) {
        return nil
      }

      return claimRequest()
    }
  }

  func poll() async {
    if let request = startPoll() {
      await perform(request)
    }
  }

  private func perform(_ request: PollRequest) async {
    logger.trace("Starting REST request for \(_config.baseUrl) - contextSha is \(request.contextSha), etag \(String(describing: request.etag))")

    let response = await _requestor.getFeatureStates(apiKeys: _config.apiKeys, contextSha: request.contextSha,
      etag: request.etag, header: request.header)

    lock.synchronized {
      defer {
        // a context change may have handed _callActive to a newer request, in which case it isn't ours to release
        if _activeRequest == request.id {
          _activeRequest = nil
          _callActive = false

          if !_stopped {
            calculateNextTimerPeriod()
          }
        }
      }

      // the context changed while we were waiting, so these features are for the old context and
      // the request made for the new one will bring the right ones
      if request.generation != _contextGeneration {
        logger.trace("context changed during REST request, ignoring result")
        return
      }

      if let response = response {
        apply(process(response))
      }
    }
  }

  func contextChangeQueued() {
    lock.synchronized {
      _pendingContextChanges += 1
      // anything in flight is now for a context on its way out
      _contextGeneration += 1
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

    if (val.statusCode == 200) || (val.statusCode == 236) || (val.statusCode == 304) {
      if let etagHeader = header("etag", in: val) {
        _etag = etagHeader
      }

      if let cacheControl = header("cache-control", in: val) {
        determineAlternativeTimeoutInterval(cacheControl)
      }

      // not modified, so the features we have are still right
      if (val.statusCode == 304) {
        return .nothing
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

  // header names are case insensitive, and HTTPURLResponse hands them back as e.g. "Etag"
  private func header(_ name: String, in response: Response<[FeatureEnvironmentCollection]>) -> String? {
    response.header.first(where: { $0.key.caseInsensitiveCompare(name) == .orderedSame })?.value
  }

  // callers must hold the lock. The repository has its own lock and never calls back into the
  // edge, so applying the result under ours keeps it in order with context changes
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
    let request: PollRequest? = lock.synchronized {
      if _pendingContextChanges > 0 {
        _pendingContextChanges -= 1
      }

      // even when the header is the one we already have, the change was queued and so anything in
      // flight has been discarded and the repository told it isn't ready, so we still ask again
      if _stopped {
        return nil
      }

      // the header is sent with each request
      if !newHeader.isEmpty {
        _header = newHeader
        _contextSha = SHA256.hash(data: Data(newHeader.utf8)).compactMap { String(format: "%02x", $0) }.joined()
      } else {
        _header = nil
        _contextSha = "0"
      }

      // the etag was for the old context's features
      _etag = nil
      _contextGeneration += 1
      // override  the  call active to allow for a second inflight request
      _activeRequest = nil
      _callActive = false
      _initialized = true
      // force a poll to happen as the header changed so the state will have changed
      _cacheTimeout = Date() - _timeoutInSeconds - 1

      // a newer context is already on its way, so let its change make the request
      if _pendingContextChanges > 0 {
        return nil
      }

      // claim the request now so a poll() from elsewhere can't take it before we make it
      return claimRequest()
    }

    if let request = request {
      await perform(request)
    }
  }

  func close() {
    lock.synchronized {
      _stopped = true
    }
  }
}
