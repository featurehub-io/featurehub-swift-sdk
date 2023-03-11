//
// Created by richard on 20/02/23.
//

import Foundation

internal protocol InternalFeatureRepository: FeatureRepository {
    func feat(_ key: String) -> FeatureStateHolder?
    func findInterceptor(_ key: String) -> InterceptorValue?


    func notReady()

    func apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue

    func updateFeatures(_ features: [FeatureState])
    func updateFeature(_ state: FeatureState)
    func deleteFeature(_ feature: inout FeatureState)

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

internal class Repository : InternalFeatureRepository {
    // these are the features (by key) and the features that we may pretend
    // exist (until they do, but they may never do)
    var features: [String: FeatureStateHolder] = [:]
    // these are the actual features
    var ids: [UUID: FeatureStateHolder] = [:]
    var _ready: Readiness = Readiness.notReady;
    var interceptors: [ValueInterceptor] = []
    var _hadInitialFeatures: Bool = false

    func registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor) {
        interceptors.append(ValueInterceptor(allowOverrideLock: allowOverrideLock,
                valueInterceptor: interceptor))
    }

    func feat(_ key: String) -> FeatureStateHolder? {
        features[key];
    }

    func findInterceptor(_ key: String) -> InterceptorValue? {
        for interceptor in interceptors {
            let val = interceptor.valueInterceptor.match(key)

            if val != nil {
                return val
            }
        }

        return nil
    }

    var readiness: Readiness {
        get {
            _ready;
        }
    }

    func notReady() {
        _ready = Readiness.notReady;
    }

    func apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue {
        AppliedValue(false, nil)
    }


    func notify(status: SSEResultState?) {
        switch (status) {
        case .ack, .bye, .none, .config:
            break
        case .failure:
            _ready = Readiness.notReady
        case .error:
            _ready = Readiness.notReady
        case .some(.features), .some(.feature), .some(.deleteFeature):
            break
        }
    }

    func updateFeatures(_ features: [FeatureState]) {
        logger.trace("received features \(features, privacy: .public)")

        for feature in features {
            updateFeature(feature)
        }

        _hadInitialFeatures = true
        _ready = Readiness.ready
    }

    func updateFeature(_ state: FeatureState) {
        var holder = ids[state.id]
        if holder?.key == nil {
            holder = FeatureStateHolder(key: state.key, repo: self, featureState: state)
            features[holder!.key] = holder
        } else if (holder?.featureState != nil) {
            let existingVersion = holder!.featureState?.version ?? -1
            let newVersion = state.version ?? 0
            if (existingVersion > newVersion) ||
                (existingVersion == newVersion && holder?.featureState?.value == state.value) {
                    return
            }
        }

        // if the key has changed, deal with it
        if holder!.key != state.key {
            features.removeValue(forKey: state.key)
            features[state.key] = holder!
        }

        holder!.setFeatureState(state)
    }

    func deleteFeature(_ feature: inout FeatureState) {
        feature.value = nil
        updateFeature(feature)
        feature.version = -1
    }

    func feature(_ key: String) -> RepositoryFeatureState? {
        features[key];
    }
}