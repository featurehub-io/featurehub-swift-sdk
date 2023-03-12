import Foundation

internal class FeatureStateHolder: RepositoryFeatureState {
  let key: String
  let repo: InternalFeatureRepository
  var internalState: FeatureState?
  var parentState: FeatureStateHolder?
  var clientContext: ClientContext?

  public init(key: String, repo: InternalFeatureRepository,
              featureState: FeatureState? = nil,
              parentState: FeatureStateHolder? = nil,
              clientContext: ClientContext? = nil) {
    self.key = key
    self.repo = repo

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
      topFeatureState()?.internalState
    }
  }

  func withContext(ctx: ClientContext) -> FeatureStateHolder {
    FeatureStateHolder(key: key, repo: repo, featureState: nil, parentState: self, clientContext: ctx)
  }

  func setFeatureState(_ state: FeatureState?) {
    internalState = state
  }

  private func topFeatureState() -> FeatureStateHolder? {
    if parentState != nil {
      return parentState!.topFeatureState()
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

    let state = fs?.internalState
    if (state == nil) {
      return nil
    }

    if fs == nil || (fs?.featureType != type) {
      return nil
    }

    if clientContext != nil && fs?.internalState?.strategies != nil {
      let featureState = fs!.internalState!
      let matched = repo.apply(strategies: featureState.strategies!,
        key: self.key, featureId: featureState.id, context: clientContext)
      if matched.matched {
        let val = InterceptorValue(matched.value).cast(type!)
        used(fs!.key, fs!.id, val)
        return val
      }
    }

    let val = state?.value?.value
    used(fs!.key, fs!.id, val)
    return val
  }

  private func used(_ key: String, _ id: UUID?, _ val: Any?) {
    if clientContext != nil && id != nil {
      Task.detached(operation: { // background this update
        await self.clientContext?.used(key, id, val)
      })
    }
  }

}
