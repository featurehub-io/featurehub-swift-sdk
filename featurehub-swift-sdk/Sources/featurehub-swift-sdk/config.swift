import Foundation

public protocol FeatureHubConfig {
  /// the apiKeys (or apiKey if using SSE) being requested from server
  var apiKeys: [String] { get }

  /// the base URL for accessing
  var baseUrl: String { get }

  /// the url that is the base for actually getting features
  var featuresUrl: String { get }

  var repository: FeatureRepository { get }

  func useRest(_ timoutInSeconds: Int)

  func useStreaming()

  func start() -> ClientContext
  func newContext() -> ClientContext

  var clientEval: Bool { get }
}

public class EdgeFeatureHubConfig: FeatureHubConfig {
  var _apiKeys: [String] = []
  var _baseUrl: String
  var _featuresUrl: String
  var edgeProvider: (_ repo: InternalFeatureRepository, _ config: FeatureHubConfig) -> EdgeService
  var _repo: Repository?
  var _serverContext: ClientContext?
  var _edge: EdgeService?

  public init(_ featurehubUrl: String, _ apiKey: [String]) {
    _apiKeys = apiKey

    _baseUrl = featurehubUrl
    if _baseUrl.last == "/" {
      _featuresUrl = _baseUrl + "features"
    } else {
      _featuresUrl = _baseUrl + "/features"
    }

    // TODO: if client key, use streaming by default, if server key, use usebased by default

    edgeProvider = { (repo, config) in
      UseBasedEdge(repo, config, 360)
    }
  }

  public var apiKeys: [String] {
    get {
      _apiKeys
    }
  }

  public var baseUrl: String {
    get {
      _baseUrl
    }
  }

  public var featuresUrl: String {
    get {
      _featuresUrl
    }
  }

  public var clientEval: Bool {
    get {
      _apiKeys.contains(where: { $0.contains("*") })
    }
  }

  public func useRest(_ timeoutInSeconds: Int) {
    edgeProvider = { (repo, config) in
      UseBasedEdge(repo, config, timeoutInSeconds)
    }
  }

  internal func useRest(_ timeoutInSeconds: Int, requestor: FeatureRequestor) {
    edgeProvider = { (repo, config) in
      UseBasedEdge(repo, config, timeoutInSeconds, requestor: requestor)
    }
  }

  private var repo: Repository {
    get {
      if _repo == nil {
        _repo = Repository()
      }

      return _repo!
    }
  }

  public var repository: FeatureRepository {
    get {
      repo
    }
  }

  private func getEdge() -> EdgeService {
    if _edge == nil {
      _edge = edgeProvider(repo, self)

      // we only poll if we are doing streaming
      if clientEval {
        Task.detached(operation: { // background this update
          await self._edge!.poll()
        })
      }
    }

    return _edge!
  }

  public func newContext() -> ClientContext {
    if clientEval {
      return ClientEvalFeatureContext(repo, getEdge())
    }

    if (_serverContext == nil) {
      _serverContext = ServerEvalFeatureContext(repo, getEdge())
    }

    return _serverContext!
  }

  public func start() -> ClientContext {
    let ctx = newContext()

    Task.detached(operation: { // background this update
      await ctx.build()
    })

    return ctx
  }

  public func useStreaming() {
    // not yet supported
  }
}
