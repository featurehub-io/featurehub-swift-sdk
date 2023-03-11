//
// Created by richard on 20/02/23.
//

import Foundation


internal class FeatureStateHolder : RepositoryFeatureState {
    let key: String
    let repo: InternalFeatureRepository
    var internalFeatureStatue: FeatureState?
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
            internalFeatureStatue = nil
        }
    }

    func exists(_ requestedFeatureState: FeatureState?) -> Bool {
        let fs = requestedFeatureState ?? internalFeatureStatue
        return fs?.l != nil
    }

    var exists: Bool {
        get {
            internalFeatureStatue?.l != nil
        }
    }

    var locked: Bool {
        get {
            if (exists) {
                return internalFeatureStatue?.l ?? false
            }

            return false
        }
    }

    var id: UUID? {
        get {
            if exists {
                return internalFeatureStatue?.id ?? nil
            }

            return nil
        }
    }

    var featureType: FeatureValueType? {
        get {
            if exists {
                return internalFeatureStatue?.type
            }

            return nil
        }
    }

    var version: Int64 {
        get {
            if exists {
                return internalFeatureStatue!.version!
            }

            return -1
        }
    }

    var string: String? {
        get {
            getValue(FeatureValueType.string) as? String? ?? nil
        }
    }

    var number: Float? {
        get {
            getValue(FeatureValueType.string) as? Float? ?? nil
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
                return getValue(internalFeatureStatue?.type) != nil
            }

            return false
        }
    }

    var featureState: FeatureState? {
        get {
            topFeatureState()?.internalFeatureStatue
        }
    }

    func withContext(ctx: ClientContext) -> FeatureStateHolder {
        FeatureStateHolder(key: key, repo: repo, featureState: nil, parentState: self, clientContext: ctx)
    }

    func setFeatureState(_ state: FeatureState?) {
        internalFeatureStatue = state
    }

    private func topFeatureState() -> FeatureStateHolder? {
        if parentState != nil {
            return parentState!.topFeatureState()
        }

        return self
    }

    private func getValue(_ type: FeatureValueType?) -> Any? {
        if clientContext != nil {
            Task.detached(operation: { // background this update
                await self.clientContext?.used()
            })
        }

        if type == nil {
            return nil
        }

        if !locked {
            // do interceptors
        }

        let fs = topFeatureState()

        let state = fs?.internalFeatureStatue
        if (state == nil) {
            return nil
        }

        if fs == nil || (fs?.featureType != type) {
            return nil
        }

        if clientContext != nil && fs?.internalFeatureStatue?.strategies != nil {
            let featureState = fs!.internalFeatureStatue!
            let matched = repo.apply(strategies: featureState.strategies!,
                    key: self.key, featureId: featureState.id, context: clientContext)
            if matched.matched {
                return InterceptorValue(matched.value).cast(type!)
            }
        }

        return state?.value?.value
    }


}