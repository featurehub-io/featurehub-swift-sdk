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
  func getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?) async -> Response<[FeatureEnvironmentCollection]>?
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
  let _apiService = FeatureServiceAPI()

  public init(_ baseUrl: String) {
    OpenAPIClientAPI.basePath = baseUrl
  }

  func getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?) async -> Response<[FeatureEnvironmentCollection]>? {
    if etag == nil {
      OpenAPIClientAPI.customHeaders.removeValue(forKey: "if-none-match")
    } else {
      OpenAPIClientAPI.customHeaders["if-none-match"] = etag!
    }

    let reqBuilder = FeatureServiceAPI.getFeatureStatesWithRequestBuilder(apiKey: apiKeys, contextSha: contextSha)

    return try? await reqBuilder.execute()
  }
}

internal class UseBasedEdge: EdgeService {
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
      !_stopped
    }
  }

  internal func ensureCacheExpired() {
    _initialized = true
    _cacheTimeout = Date() - _timeoutInSeconds - 1
  }

  internal func ensureCacheNotExpired() {
    _initialized = true
    _cacheTimeout = Date() + (_timeoutInSeconds/2)
  }

  internal var timeoutInSeconds: Double {
    get {
      _timeoutInSeconds
    }
  }

  internal var etag: String? {
    get  {
      _etag
    }

    set {
      _etag = newValue
    }
  }

  func poll() async {
    // they set the timeout to zero, so we don't ask again
    if (_initialized && _timeoutInSeconds == 0) {
      return
    }

    // if the cache timeout < current date, then it will be order ascending and we should poll
    if _stopped || _callActive || (_initialized && (_cacheTimeout.compare(Date()) != ComparisonResult.orderedAscending)) {
      return
    }

    _initialized = true

    defer {
      _callActive = false

      if !_stopped {
        calculateNextTimerPeriod()
      }
    }

    _callActive = true

    logger.trace("Starting REST request for \(_config.baseUrl) - contextSha is \(_contextSha), etag \(String(describing: _etag))")

    if let response = await _requestor.getFeatureStates(apiKeys: _config.apiKeys, contextSha: _contextSha, etag: _etag) {
      process(response)
    }
  }

  private func process(_ val: Response<[FeatureEnvironmentCollection]>) {
    logger.trace("REST status is \(val.statusCode)")

    if (val.statusCode == 200) || (val.statusCode == 236) {
      if let etagHeader = val.header["etag"] {
        _etag = etagHeader
      }

      if let cacheControl = val.header["cache-control"] {
        determineAlternativeTimeoutInterval(cacheControl)
      }

      processResult(val.body)

      if (val.statusCode == 236) {
        _stopped = true
      }

    } else if (val.statusCode == 400 || val.statusCode == 404) {
      _stopped = true
      _repo.notify(status: SSEResultState.failure)
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

  private func processResult(_ environments: [FeatureEnvironmentCollection]?) -> Void {
    if environments != nil {
      let allFeatures: [FeatureState] = environments!.map({ $0.features }).compactMap({ $0 }).flatMap({ $0 })

      if allFeatures.count > 0 {
        _repo.updateFeatures(allFeatures)
      } else {
        _repo.empty()
      }
    }
  }

  func context_change(_ newHeader: String) async {
    if (newHeader != _header && canStart) {
      if !newHeader.isEmpty {
        _header = newHeader
        _contextSha = SHA256.hash(data: Data(newHeader.utf8)).compactMap { String(format: "%02x", $0) }.joined()
        OpenAPIClientAPI.customHeaders["x-featurehub"] = newHeader
      } else {
        OpenAPIClientAPI.customHeaders.removeValue(forKey: "x-featurehub")
        _contextSha = "0"
      }

      // override  the  call active to allow for a second inflight request
      _callActive = false
      _initialized = true
      // force a poll to happen as the header changed so the state will have changed
      _cacheTimeout = Date() - _timeoutInSeconds - 1

      await poll()
    }
  }

  func close() {
    _stopped = true
  }
}
