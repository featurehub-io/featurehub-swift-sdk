///
/// FeatureHub: Usage based edge. This service holds an update interval
/// which can be overridden by the server. It requests state by calling the
/// GET api if the interval has expired.
///
/// This concept is based on the same one from the Dart API and is intended for Mobile usage.
///

import Foundation

internal protocol FeatureRequestor {
  func getFeatureStates(apiKeys: [String], contextSha: String?) async -> Response<[FeatureEnvironmentCollection]>?
}

internal struct DefaultFeatureRequestor: FeatureRequestor {
  let _apiService = FeatureServiceAPI()

  public init(_ baseUrl: String) {
    OpenAPIClientAPI.basePath = baseUrl
  }

  func getFeatureStates(apiKeys: [String], contextSha: String?) async -> Response<[FeatureEnvironmentCollection]>? {
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

  public init(_ repo: InternalFeatureRepository, _ config: FeatureHubConfig, _ timeoutInSeconds: Int?,
              requestor: FeatureRequestor? = nil) {
    _repo = repo
    _config = config
    _timeoutInSeconds = Double(timeoutInSeconds ?? 360)
    _cacheTimeout = Date() - _timeoutInSeconds - 1  // ensure the cache is already timed out
    _requestor = requestor ?? DefaultFeatureRequestor(config.baseUrl)
  }

  func initialize() async {
    if (canStart) {
      _initialized = true
      _cacheTimeout = Date() + _timeoutInSeconds
      await poll()
    }
  }

  var canStart: Bool {
    get {
      !_initialized && !_stopped
    }
  }

  func poll() async {
    // if we are not initialized, we are stopped, we are busy making a call or the cache hasn't expired yet, just return
    if !_initialized || _stopped || _callActive || _cacheTimeout.compare(Date()) == ComparisonResult.orderedAscending {
      return
    }

    defer {
      _callActive = false

      if !_stopped {
        calculateNextTimerPeriod()
      }
    }

    _callActive = true

    print("Starting REST request for \(self._config.featuresUrl) - contextSha is \(self._contextSha)")
    logger.trace("Starting REST request for \(self._config.featuresUrl, privacy: .public) - contextSha is \(self._contextSha, privacy: .public)")

    if let response = await _requestor.getFeatureStates(apiKeys: _config.apiKeys, contextSha: _contextSha) {
      process(response)
    } else {
      print("failed")
    }
  }

  private func process(_ val: Response<[FeatureEnvironmentCollection]>) {
    print("result is \(val)")
    logger.trace("Result \(val.statusCode, privacy: .public)")
    if (val.statusCode == 200) || (val.statusCode == 236) {
      processResult(val.body)

      if (val.statusCode == 236) {
        _stopped = true
      }

      // TODO: change polling interval, etc
    } else if (val.statusCode == 400 || val.statusCode == 404) {
      _stopped = true
      _repo.notify(status: SSEResultState.failure)
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
        _repo.notify(status: SSEResultState.failure)
      }
    }
  }

  func context_change(new_header: String) async {
    if (new_header != _header || canStart) {
      if !new_header.isEmpty {
        OpenAPIClientAPI.customHeaders["x-fh-version"] = new_header
      }
      await initialize()
    }
  }

  func close() {
    _stopped = true
  }
}
