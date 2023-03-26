import Foundation

internal class FeatureStateHolder: RepositoryFeatureState {
  var _key: String
  let repo: InternalFeatureRepository
  var internalState: FeatureState?
  var parentState: FeatureStateHolder?
  var clientContext: InternalContext?

  public init(key: String, repo: InternalFeatureRepository,
              featureState: FeatureState? = nil,
              parentState: FeatureStateHolder? = nil,
              clientContext: InternalContext? = nil) {
    _key = key
    self.repo = repo
    self.parentState = parentState
    self.clientContext = clientContext

    if featureState != nil {
      setFeatureState(featureState)
    } else {
      internalState = nil
    }
  }

  func exists(_ requestedFeatureState: FeatureState?) -> Bool {
    let fs = requestedFeatureState ?? internalState
    return fs?.l != nil
  }

  var key: String {
    get { // we always walk up the tree to get the key in case it changed
      return parentState?.key ?? _key
    }
  }

  var exists: Bool {
    get {
      // we don't check used() here even though it might be logical as it creates a stack overflow
      internalState?.l != nil
    }
  }

  var locked: Bool {
    get {
      if (exists) {
        return internalState?.l ?? false
      }

      return false
    }
  }

  var id: UUID? {
    get {
      if exists {
        return internalState?.id ?? nil
      }

      return nil
    }
  }

  var featureType: FeatureValueType? {
    get {
      if exists {
        return internalState?.type
      }

      return nil
    }
  }

  var version: Int64 {
    get {
      if exists {
        return internalState!.version!
      }

      return -1
    }
  }

  var string: String? {
    get {
      getValue(FeatureValueType.string) as? String? ?? nil
    }
  }

  var number: Double? {
    get {
      if let num = getValue(FeatureValueType.number) {
        if num is Int {
          return Double(num as! Int)
        }

        if num is Float {
          return Double(num as! Float)
        }

        return num as? Double
      } else {
        return nil
      }
    }
  }

  var json: String? {
    get {
      getValue(FeatureValueType.json) as? String? ?? nil
    }
  }

  var flag: Bool? {
    get {
      getValue(FeatureValueType.boolean) as? Bool? ?? nil
    }
  }

  var enabled: Bool {
    get {
      flag == true
    }
  }

  var hasValue: Bool {
    get {
      if (exists) {
        return getValue(internalState?.type) != nil
      }

      return false
    }
  }

  var featureState: FeatureState? {
    get {
      topFeatureState().internalState
    }
  }

  func withContext(ctx: InternalContext) -> FeatureStateHolder {
    FeatureStateHolder(key: _key, repo: repo, featureState: nil, parentState: self, clientContext: ctx)
  }

  func setFeatureState(_ state: FeatureState?) {
    internalState = state
    if let k = state?.key {
      _key = k
    }
  }

  private func topFeatureState() -> FeatureStateHolder {
    if let ps = parentState {
      return ps.topFeatureState()
    }

    return self
  }

  private func getValue(_ type: FeatureValueType?) -> Any? {
    if type == nil {
      return nil
    }

    if !locked {
      // do interceptors
    }

    let fs = topFeatureState()

    let state = fs.internalState
    if state == nil {
      return nil
    }

    if fs.featureType != type {
      return nil
    }

    if clientContext != nil && fs.internalState?.strategies != nil {
      let featureState = fs.internalState!
      let matched = repo.apply(strategies: featureState.strategies!,
        key: key, featureId: featureState.id, context: clientContext)
      if matched.matched {
        let val = InterceptorValue(matched.value).cast(type!)
        used(fs.key, fs.id, val, type!)
        return val
      }
    }

    let val = state?.value?.value
    used(fs.key, fs.id, val, type!)
    return val
  }

  private func used(_ key: String, _ id: UUID?, _ val: Any?, _ valueType: FeatureValueType) {
    if clientContext != nil && id != nil {
      Task.detached(operation: { // background this update
        await self.clientContext?.used(key, id, val, valueType)
      })
    }
  }

}
