import Foundation

internal protocol InternalFeatureRepository: FeatureRepository {
  // there are no features, but the keys were valid
  func empty() -> Void

  func feat(_ key: String) -> FeatureStateHolder
  func findInterceptor(_ key: String) -> InterceptorValue?

  func notReady()

  func apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue

  func updateFeatures(_ features: [FeatureState])
  func updateFeature(_ state: FeatureState)
  func deleteFeature(_ feature: FeatureState)

  func notify(status: SSEResultState?) -> Void
}


public protocol FeatureValueInterceptor {
  func match(_ key: String) -> InterceptorValue?
}

internal class ValueInterceptor {
  let allowOverrideLock: Bool
  let valueInterceptor: FeatureValueInterceptor

  init(allowOverrideLock: Bool, valueInterceptor: FeatureValueInterceptor) {
    self.allowOverrideLock = allowOverrideLock
    self.valueInterceptor = valueInterceptor
  }
}

internal class Repository: InternalFeatureRepository {
  // the edge service updates us from its own task while the application reads features
  // from whatever thread it likes, so every access to the state below has to be serialised
  private let lock = NSRecursiveLock()
  // these are the features (by key) and the features that we may pretend
  // exist (until they do, but they may never do)
  private var features: [String: FeatureStateHolder] = [:]
  // these are the actual features
  private var ids: [UUID: FeatureStateHolder] = [:]
  private var _ready: Readiness = Readiness.notReady;
  private var interceptors: [ValueInterceptor] = []
  private var _hadInitialFeatures: Bool = false


  func registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor) {
    lock.synchronized {
      interceptors.append(ValueInterceptor(allowOverrideLock: allowOverrideLock,
        valueInterceptor: interceptor))
    }
  }

  // used to expose the internal API
  func feat(_ key: String) -> FeatureStateHolder {
    lock.synchronized {
      if let existing = features[key] {
        return existing
      }

      logger.trace("feature \(key) doesnt exist, creating")
      let f = FeatureStateHolder(key: key, repo: self)
      features[key] = f

      return f
    }
  }

  func findInterceptor(_ key: String) -> InterceptorValue? {
    // interceptors are application code, so don't hold the lock while calling them
    for interceptor in lock.synchronized({ interceptors }) {
      let val = interceptor.valueInterceptor.match(key)

      if val != nil {
        return val
      }
    }

    return nil
  }

  var readiness: Readiness {
    get {
      lock.synchronized {
        _ready
      }
    }
  }

  func notReady() {
    lock.synchronized {
      _ready = Readiness.notReady
    }
  }

  func apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue {
    AppliedValue(false, nil)
  }


  func notify(status: SSEResultState?) {
    lock.synchronized {
      switch (status) {
      case .ack, .bye, .none, .config:
        break
      case .failure:
        _ready = Readiness.failed
      case .error:
        _ready = Readiness.failed
      case .some(.features), .some(.feature), .some(.deleteFeature):
        break
      }
    }
  }

  func updateFeatures(_ features: [FeatureState]) {
    logger.trace("received features \(features)")

    lock.synchronized {
      for feature in features {
        update(feature)
      }

      _hadInitialFeatures = true
      _ready = Readiness.ready
    }
  }

  func updateFeature(_ state: FeatureState) {
    lock.synchronized {
      update(state)
    }
  }

  // callers must hold the lock
  private func update(_ state: FeatureState) {
    var holder = ids[state.id] ?? features[state.key]
    if holder?.key == nil {
      holder = FeatureStateHolder(key: state.key, repo: self, featureState: state)
      features[holder!.key] = holder
      ids[state.id] = holder // so we can find it again if its key is renamed
    } else if (holder?.featureState != nil) {
      let existingVersion = holder!.featureState?.version ?? -1
      let newVersion = state.version ?? 0
      if (existingVersion > newVersion) ||
           (existingVersion == newVersion && holder?.featureState?.value == state.value) {
        return
      }
    } else { // it is a holder with no state, which means its a fake placeholder, now we have its id so we need to store it
      ids[state.id] = holder
    }

    // if the key has changed, deal with it
    let oldKey = holder!.key
    if oldKey != state.key {
      features.removeValue(forKey: oldKey)
      features[state.key] = holder!
    }

    holder!.setFeatureState(state)
  }

  func deleteFeature(_ feature: FeatureState) {
    updateFeature(FeatureState(id: feature.id, key: feature.key, l: nil, version: feature.version, value: nil))
  }

  // used to expose the external API
  func feature(_ key: String) -> RepositoryFeatureState {
    feat(key)
  }

  // there are no features, not the repository can be used
  func empty() {
    lock.synchronized {
      _ready = .ready
    }
  }
}
