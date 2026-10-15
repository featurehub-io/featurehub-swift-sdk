import Foundation

public protocol FeatureHubConfig {
  /// the apiKeys (or apiKey if using SSE) being requested from server
  var apiKeys: [String] { get }

  /// the base URL for accessing
  var baseUrl: String { get }

  /// the url that is the base for actually getting features
  var featuresUrl: String { get }

  var repository: FeatureRepository { get }

  func cacheTimeout(_ timoutInSeconds: Int) -> FeatureHubConfig

//  func useStreaming() -> FeatureHubConfig

  func start() -> ClientContext
  func newContext() -> ClientContext

  var clientEval: Bool { get }
}

struct RuntimeError: Error {
  let message: String

  init(_ message: String) {
    self.message = message
  }

  public var localizedDescription: String {
    message
  }
}

public class EdgeFeatureHubConfig: FeatureHubConfig {
  var _apiKeys: [String] = []
  var _baseUrl: String
  var _featuresUrl: String
  var edgeProvider: (_ repo: InternalFeatureRepository, _ config: FeatureHubConfig) -> EdgeService
  var _repo: Repository?
  var _serverContext: ClientContext?
  var _edge: EdgeService?
  // the application may ask for contexts from several threads at once, so the lazily created
  // repository, edge and server context are guarded to make sure only one of each is ever made
  private let lock = NSRecursiveLock()

  private func withLock<T>(_ block: () -> T) -> T {
    lock.lock()
    defer { lock.unlock() }
    return block()
  }

  public init(_ featurehubUrl: String, _ apiKey: [String]) throws {
    _apiKeys = apiKey

    _baseUrl = featurehubUrl
    if _baseUrl.last == "/" {
      _featuresUrl = _baseUrl + "features"
    } else {
      _featuresUrl = _baseUrl + "/features"
    }

    if apiKey.contains(where: { key in key.contains("*") }) {
      throw RuntimeError("Does not support client side keys yet")
    }

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

  public func cacheTimeout(_ timeoutInSeconds: Int) -> FeatureHubConfig {
    withLock {
      edgeProvider = { (repo, config) in
        UseBasedEdge(repo, config, timeoutInSeconds)
      }
    }

    return self
  }

  internal func useRest(_ timeoutInSeconds: Int, requestor: FeatureRequestor) {
    withLock {
      edgeProvider = { (repo, config) in
        UseBasedEdge(repo, config, timeoutInSeconds, requestor: requestor)
      }
    }
  }

  private var repo: Repository {
    get {
      withLock {
        if _repo == nil {
          _repo = Repository()
        }

        return _repo!
      }
    }
  }

  public var repository: FeatureRepository {
    get {
      repo
    }
  }

  private func getEdge() -> EdgeService {
    withLock {
      if let edge = _edge {
        return edge
      }

      let edge = edgeProvider(repo, self)
      _edge = edge

      // we only poll if we are doing streaming
      if clientEval {
        Task.detached(operation: { // background this update
          await edge.poll()
        })
      }

      return edge
    }
  }

  public func newContext() -> ClientContext {
    if clientEval {
      return ClientEvalFeatureContext(repo, getEdge())
    }

    return withLock {
      if (_serverContext == nil) {
        _serverContext = ServerEvalFeatureContext(repo, getEdge())
      }

      return _serverContext!
    }
  }

  public func start() -> ClientContext {
    let ctx = newContext()

    Task.detached(operation: { // background this update
      await ctx.build()
    })

    return ctx
  }

  public func useStreaming() -> FeatureHubConfig {
    // not yet supported
    return self
  }
}
