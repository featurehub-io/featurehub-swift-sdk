import Foundation

internal enum ContextKeys: String {
  case userKey = "userkey", session = "session", country = "country", platform = "platform", device = "device", version = "version"
}

internal protocol InternalContext: ClientContext {
  func used(_ key: String, _ id: UUID?, _ val: Any?, _ valueType: FeatureValueType) async
}

internal class ClientEvalFeatureContext: BaseClientContext, InternalContext {
  let edge: EdgeService
  let internalRepo: InternalFeatureRepository

  public init(_ repo: InternalFeatureRepository, _ edge: EdgeService) {
    self.edge = edge
    internalRepo = repo
    super.init(repo)
  }

  @discardableResult
  override func build() async -> ClientContext {
    self
  }

  override func feature(_ key: String) -> RepositoryFeatureState {
    internalRepo.feat(key).withContext(ctx: self)
  }
}

internal class ServerEvalFeatureContext: BaseClientContext, InternalContext {
  // build() can be called from several tasks at once (start() kicks one off in the background),
  // so the header we last sent and the queue of context changes are guarded
  private let buildLock = NSLock()
  private var oldHeader: String?
  // context changes are sent to the edge one at a time and in the order they were made, so the
  // edge always ends up with the most recent context
  private var lastContextChange: Task<Void, Never>?
  let edge: EdgeService
  let internalRepo: InternalFeatureRepository

  public init(_ repo: InternalFeatureRepository, _ edge: EdgeService) {
    self.edge = edge
    internalRepo = repo
    super.init(repo)
  }

  @discardableResult
  override func build() async -> ClientContext {
    // wait for this context to reach the edge, even if an earlier build queued it
    if let change = queueContextChange() {
      await change.value
    }

    return self
  }

  // works out the header for the attributes as they are now and, if it has changed, queues it to
  // be sent to the edge after any earlier change. Returns the change to wait for.
  private func queueContextChange() -> Task<Void, Never>? {
    buildLock.lock()
    defer { buildLock.unlock() }

    let attrs = attributes
    let newHeader = attrs.keys
            .sorted()
            .map {
              encodePair($0, attrs[$0])
            }
            .compactMap({ $0 })
            .joined(separator: ",")

    if (newHeader == oldHeader) && (oldHeader != nil) {
      // unchanged, but it may not have reached the edge yet
      return lastContextChange
    }

    logger.trace("server eval context, header changed to \(newHeader)")
    oldHeader = newHeader
    // tell the edge first, so a response for the old context can't make the repository ready again
    (edge as? ContextChangeAware)?.contextChangeQueued()
    internalRepo.notReady()

    let previous = lastContextChange
    let edge = self.edge
    let change = Task {
      await previous?.value
      await edge.context_change(newHeader)
    }

    lastContextChange = change
    return change
  }

  private func encodePair(_ key: String, _ value: [String]?) -> String? {
    if value == nil {
      return nil
    }

    let k = encodeVal(key)
    let v = value?.compactMap({ $0 }).map({ encodeVal($0) }).compactMap({ $0 }).joined(separator: "%2C") ?? ""

    return "\(k)=\(v)"
  }

  private func encodeVal(_ val: String) -> String {
    val.replacingOccurrences(of: ",", with: "%2C" ).replacingOccurrences(of: "=", with: "%3D")
  }

  override func used(_ key: String, _ id: UUID?, _ val: Any?, _ valueType: FeatureValueType) async {
    await edge.poll()
  }

  // we override this to pass ourselves as context so that the refresh of the cache can happen
  override func feature(_ key: String) -> RepositoryFeatureState {
    internalRepo.feat(key).withContext(ctx: self)
  }
}
