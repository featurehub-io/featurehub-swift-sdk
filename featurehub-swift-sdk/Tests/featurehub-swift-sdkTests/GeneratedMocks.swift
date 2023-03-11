// MARK: - Mocks generated from file: Sources/featurehub-swift-sdk/featurehub_swift_sdk.swift at 2023-03-11 01:54:33 +0000


import Cuckoo
@testable import featurehub_swift_sdk

import Foundation






public class MockEdgeService: EdgeService, Cuckoo.ProtocolMock {
    
    public typealias MocksType = EdgeService
    
    public typealias Stubbing = __StubbingProxy_EdgeService
    public typealias Verification = __VerificationProxy_EdgeService

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: EdgeService?

    public func enableDefaultImplementation(_ stub: EdgeService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
    public func initialize() async {
        
    return await cuckoo_manager.call(
    """
    initialize() async
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.initialize())
        
    }
    
    
    
    
    
    public func poll() async {
        
    return await cuckoo_manager.call(
    """
    poll() async
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.poll())
        
    }
    
    
    
    
    
    public func context_change(new_header: String) async {
        
    return await cuckoo_manager.call(
    """
    context_change(new_header: String) async
    """,
            parameters: (new_header),
            escapingParameters: (new_header),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.context_change(new_header: new_header))
        
    }
    
    
    
    
    
    public func close()  {
        
    return cuckoo_manager.call(
    """
    close()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.close())
        
    }
    
    

    public struct __StubbingProxy_EdgeService: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func initialize() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEdgeService.self, method:
    """
    initialize() async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func poll() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEdgeService.self, method:
    """
    poll() async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func context_change<M1: Cuckoo.Matchable>(new_header: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: new_header) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEdgeService.self, method:
    """
    context_change(new_header: String) async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func close() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEdgeService.self, method:
    """
    close()
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_EdgeService: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func initialize() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    initialize() async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func poll() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    poll() async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func context_change<M1: Cuckoo.Matchable>(new_header: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: new_header) { $0 }]
            return cuckoo_manager.verify(
    """
    context_change(new_header: String) async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func close() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    close()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class EdgeServiceStub: EdgeService {
    

    

    
    
    
    
    public func initialize() async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func poll() async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func context_change(new_header: String) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func close()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}










public class MockFeatureRepository: FeatureRepository, Cuckoo.ProtocolMock {
    
    public typealias MocksType = FeatureRepository
    
    public typealias Stubbing = __StubbingProxy_FeatureRepository
    public typealias Verification = __VerificationProxy_FeatureRepository

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FeatureRepository?

    public func enableDefaultImplementation(_ stub: FeatureRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
    public var readiness: Readiness {
        get {
            return cuckoo_manager.getter("readiness",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.readiness)
        }
        
    }
    
    

    

    
    
    
    
    public func feature(_ key: String) -> RepositoryFeatureState? {
        
    return cuckoo_manager.call(
    """
    feature(_: String) -> RepositoryFeatureState?
    """,
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.feature(key))
        
    }
    
    
    
    
    
    public func registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)  {
        
    return cuckoo_manager.call(
    """
    registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)
    """,
            parameters: (allowOverrideLock, interceptor),
            escapingParameters: (allowOverrideLock, interceptor),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.registerFeatureValueInterceptor(allowOverrideLock: allowOverrideLock, interceptor: interceptor))
        
    }
    
    

    public struct __StubbingProxy_FeatureRepository: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var readiness: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFeatureRepository, Readiness> {
            return .init(manager: cuckoo_manager, name: "readiness")
        }
        
        
        
        
        
        func feature<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ProtocolStubFunction<(String), RepositoryFeatureState?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFeatureRepository.self, method:
    """
    feature(_: String) -> RepositoryFeatureState?
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func registerFeatureValueInterceptor<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(allowOverrideLock: M1, interceptor: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Bool, FeatureValueInterceptor)> where M1.MatchedType == Bool, M2.MatchedType == FeatureValueInterceptor {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, FeatureValueInterceptor)>] = [wrap(matchable: allowOverrideLock) { $0.0 }, wrap(matchable: interceptor) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFeatureRepository.self, method:
    """
    registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_FeatureRepository: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var readiness: Cuckoo.VerifyReadOnlyProperty<Readiness> {
            return .init(manager: cuckoo_manager, name: "readiness", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func feature<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), RepositoryFeatureState?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return cuckoo_manager.verify(
    """
    feature(_: String) -> RepositoryFeatureState?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func registerFeatureValueInterceptor<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(allowOverrideLock: M1, interceptor: M2) -> Cuckoo.__DoNotUse<(Bool, FeatureValueInterceptor), Void> where M1.MatchedType == Bool, M2.MatchedType == FeatureValueInterceptor {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, FeatureValueInterceptor)>] = [wrap(matchable: allowOverrideLock) { $0.0 }, wrap(matchable: interceptor) { $0.1 }]
            return cuckoo_manager.verify(
    """
    registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class FeatureRepositoryStub: FeatureRepository {
    
    
    
    
    public var readiness: Readiness {
        get {
            return DefaultValueRegistry.defaultValue(for: (Readiness).self)
        }
        
    }
    
    

    

    
    
    
    
    public func feature(_ key: String) -> RepositoryFeatureState?  {
        return DefaultValueRegistry.defaultValue(for: (RepositoryFeatureState?).self)
    }
    
    
    
    
    
    public func registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Sources/featurehub-swift-sdk/features.swift at 2023-03-11 01:54:33 +0000


import Cuckoo
@testable import featurehub_swift_sdk

import Foundation






public class MockRepositoryFeatureState: RepositoryFeatureState, Cuckoo.ProtocolMock {
    
    public typealias MocksType = RepositoryFeatureState
    
    public typealias Stubbing = __StubbingProxy_RepositoryFeatureState
    public typealias Verification = __VerificationProxy_RepositoryFeatureState

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: RepositoryFeatureState?

    public func enableDefaultImplementation(_ stub: RepositoryFeatureState) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
    public var exists: Bool {
        get {
            return cuckoo_manager.getter("exists",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.exists)
        }
        
    }
    
    
    
    
    
    public var locked: Bool {
        get {
            return cuckoo_manager.getter("locked",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.locked)
        }
        
    }
    
    
    
    
    
    public var id: UUID? {
        get {
            return cuckoo_manager.getter("id",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.id)
        }
        
    }
    
    
    
    
    
    public var featureType: FeatureValueType? {
        get {
            return cuckoo_manager.getter("featureType",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.featureType)
        }
        
    }
    
    
    
    
    
    public var version: Int64 {
        get {
            return cuckoo_manager.getter("version",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.version)
        }
        
    }
    
    
    
    
    
    public var string: String? {
        get {
            return cuckoo_manager.getter("string",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.string)
        }
        
    }
    
    
    
    
    
    public var number: Float? {
        get {
            return cuckoo_manager.getter("number",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.number)
        }
        
    }
    
    
    
    
    
    public var json: String? {
        get {
            return cuckoo_manager.getter("json",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.json)
        }
        
    }
    
    
    
    
    
    public var flag: Bool? {
        get {
            return cuckoo_manager.getter("flag",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.flag)
        }
        
    }
    
    
    
    
    
    public var enabled: Bool {
        get {
            return cuckoo_manager.getter("enabled",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.enabled)
        }
        
    }
    
    
    
    
    
    public var hasValue: Bool {
        get {
            return cuckoo_manager.getter("hasValue",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.hasValue)
        }
        
    }
    
    

    

    

    public struct __StubbingProxy_RepositoryFeatureState: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var exists: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, Bool> {
            return .init(manager: cuckoo_manager, name: "exists")
        }
        
        
        
        
        var locked: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, Bool> {
            return .init(manager: cuckoo_manager, name: "locked")
        }
        
        
        
        
        var id: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, UUID?> {
            return .init(manager: cuckoo_manager, name: "id")
        }
        
        
        
        
        var featureType: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, FeatureValueType?> {
            return .init(manager: cuckoo_manager, name: "featureType")
        }
        
        
        
        
        var version: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, Int64> {
            return .init(manager: cuckoo_manager, name: "version")
        }
        
        
        
        
        var string: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, String?> {
            return .init(manager: cuckoo_manager, name: "string")
        }
        
        
        
        
        var number: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, Float?> {
            return .init(manager: cuckoo_manager, name: "number")
        }
        
        
        
        
        var json: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, String?> {
            return .init(manager: cuckoo_manager, name: "json")
        }
        
        
        
        
        var flag: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, Bool?> {
            return .init(manager: cuckoo_manager, name: "flag")
        }
        
        
        
        
        var enabled: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, Bool> {
            return .init(manager: cuckoo_manager, name: "enabled")
        }
        
        
        
        
        var hasValue: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, Bool> {
            return .init(manager: cuckoo_manager, name: "hasValue")
        }
        
        
        
    }

    public struct __VerificationProxy_RepositoryFeatureState: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var exists: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "exists", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var locked: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "locked", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var id: Cuckoo.VerifyReadOnlyProperty<UUID?> {
            return .init(manager: cuckoo_manager, name: "id", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var featureType: Cuckoo.VerifyReadOnlyProperty<FeatureValueType?> {
            return .init(manager: cuckoo_manager, name: "featureType", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var version: Cuckoo.VerifyReadOnlyProperty<Int64> {
            return .init(manager: cuckoo_manager, name: "version", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var string: Cuckoo.VerifyReadOnlyProperty<String?> {
            return .init(manager: cuckoo_manager, name: "string", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var number: Cuckoo.VerifyReadOnlyProperty<Float?> {
            return .init(manager: cuckoo_manager, name: "number", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var json: Cuckoo.VerifyReadOnlyProperty<String?> {
            return .init(manager: cuckoo_manager, name: "json", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var flag: Cuckoo.VerifyReadOnlyProperty<Bool?> {
            return .init(manager: cuckoo_manager, name: "flag", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var enabled: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "enabled", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var hasValue: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "hasValue", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
    }
}


public class RepositoryFeatureStateStub: RepositoryFeatureState {
    
    
    
    
    public var exists: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
    
    
    
    public var locked: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
    
    
    
    public var id: UUID? {
        get {
            return DefaultValueRegistry.defaultValue(for: (UUID?).self)
        }
        
    }
    
    
    
    
    
    public var featureType: FeatureValueType? {
        get {
            return DefaultValueRegistry.defaultValue(for: (FeatureValueType?).self)
        }
        
    }
    
    
    
    
    
    public var version: Int64 {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int64).self)
        }
        
    }
    
    
    
    
    
    public var string: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
    }
    
    
    
    
    
    public var number: Float? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Float?).self)
        }
        
    }
    
    
    
    
    
    public var json: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
    }
    
    
    
    
    
    public var flag: Bool? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool?).self)
        }
        
    }
    
    
    
    
    
    public var enabled: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
    
    
    
    public var hasValue: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    

    

    
}




