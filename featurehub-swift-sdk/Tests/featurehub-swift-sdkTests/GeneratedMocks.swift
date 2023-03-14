// MARK: - Mocks generated from file: Sources/featurehub-swift-sdk/config.swift at 2023-03-14 08:42:49 +0000


import Cuckoo
@testable import featurehub_swift_sdk

import Foundation






public class MockFeatureHubConfig: FeatureHubConfig, Cuckoo.ProtocolMock {
    
    public typealias MocksType = FeatureHubConfig
    
    public typealias Stubbing = __StubbingProxy_FeatureHubConfig
    public typealias Verification = __VerificationProxy_FeatureHubConfig

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FeatureHubConfig?

    public func enableDefaultImplementation(_ stub: FeatureHubConfig) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
    public var apiKeys: [String] {
        get {
            return cuckoo_manager.getter("apiKeys",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.apiKeys)
        }
        
    }
    
    
    
    
    
    public var baseUrl: String {
        get {
            return cuckoo_manager.getter("baseUrl",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.baseUrl)
        }
        
    }
    
    
    
    
    
    public var featuresUrl: String {
        get {
            return cuckoo_manager.getter("featuresUrl",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.featuresUrl)
        }
        
    }
    
    
    
    
    
    public var repository: FeatureRepository {
        get {
            return cuckoo_manager.getter("repository",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.repository)
        }
        
    }
    
    
    
    
    
    public var clientEval: Bool {
        get {
            return cuckoo_manager.getter("clientEval",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.clientEval)
        }
        
    }
    
    

    

    
    
    
    
    public func useRest(_ timoutInSeconds: Int)  {
        
    return cuckoo_manager.call(
    """
    useRest(_: Int)
    """,
            parameters: (timoutInSeconds),
            escapingParameters: (timoutInSeconds),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.useRest(timoutInSeconds))
        
    }
    
    
    
    
    
    public func useStreaming()  {
        
    return cuckoo_manager.call(
    """
    useStreaming()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.useStreaming())
        
    }
    
    
    
    
    
    public func start() -> ClientContext {
        
    return cuckoo_manager.call(
    """
    start() -> ClientContext
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.start())
        
    }
    
    
    
    
    
    public func newContext() -> ClientContext {
        
    return cuckoo_manager.call(
    """
    newContext() -> ClientContext
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.newContext())
        
    }
    
    

    public struct __StubbingProxy_FeatureHubConfig: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var apiKeys: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFeatureHubConfig, [String]> {
            return .init(manager: cuckoo_manager, name: "apiKeys")
        }
        
        
        
        
        var baseUrl: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFeatureHubConfig, String> {
            return .init(manager: cuckoo_manager, name: "baseUrl")
        }
        
        
        
        
        var featuresUrl: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFeatureHubConfig, String> {
            return .init(manager: cuckoo_manager, name: "featuresUrl")
        }
        
        
        
        
        var repository: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFeatureHubConfig, FeatureRepository> {
            return .init(manager: cuckoo_manager, name: "repository")
        }
        
        
        
        
        var clientEval: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFeatureHubConfig, Bool> {
            return .init(manager: cuckoo_manager, name: "clientEval")
        }
        
        
        
        
        
        func useRest<M1: Cuckoo.Matchable>(_ timoutInSeconds: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: timoutInSeconds) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFeatureHubConfig.self, method:
    """
    useRest(_: Int)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func useStreaming() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockFeatureHubConfig.self, method:
    """
    useStreaming()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func start() -> Cuckoo.ProtocolStubFunction<(), ClientContext> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockFeatureHubConfig.self, method:
    """
    start() -> ClientContext
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func newContext() -> Cuckoo.ProtocolStubFunction<(), ClientContext> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockFeatureHubConfig.self, method:
    """
    newContext() -> ClientContext
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_FeatureHubConfig: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var apiKeys: Cuckoo.VerifyReadOnlyProperty<[String]> {
            return .init(manager: cuckoo_manager, name: "apiKeys", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var baseUrl: Cuckoo.VerifyReadOnlyProperty<String> {
            return .init(manager: cuckoo_manager, name: "baseUrl", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var featuresUrl: Cuckoo.VerifyReadOnlyProperty<String> {
            return .init(manager: cuckoo_manager, name: "featuresUrl", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var repository: Cuckoo.VerifyReadOnlyProperty<FeatureRepository> {
            return .init(manager: cuckoo_manager, name: "repository", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var clientEval: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "clientEval", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func useRest<M1: Cuckoo.Matchable>(_ timoutInSeconds: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: timoutInSeconds) { $0 }]
            return cuckoo_manager.verify(
    """
    useRest(_: Int)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func useStreaming() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    useStreaming()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func start() -> Cuckoo.__DoNotUse<(), ClientContext> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    start() -> ClientContext
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func newContext() -> Cuckoo.__DoNotUse<(), ClientContext> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    newContext() -> ClientContext
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class FeatureHubConfigStub: FeatureHubConfig {
    
    
    
    
    public var apiKeys: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
    
    
    
    public var baseUrl: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    
    
    
    public var featuresUrl: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    
    
    
    public var repository: FeatureRepository {
        get {
            return DefaultValueRegistry.defaultValue(for: (FeatureRepository).self)
        }
        
    }
    
    
    
    
    
    public var clientEval: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    

    

    
    
    
    
    public func useRest(_ timoutInSeconds: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func useStreaming()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func start() -> ClientContext  {
        return DefaultValueRegistry.defaultValue(for: (ClientContext).self)
    }
    
    
    
    
    
    public func newContext() -> ClientContext  {
        return DefaultValueRegistry.defaultValue(for: (ClientContext).self)
    }
    
    
}










public class MockEdgeFeatureHubConfig: EdgeFeatureHubConfig, Cuckoo.ClassMock {
    
    public typealias MocksType = EdgeFeatureHubConfig
    
    public typealias Stubbing = __StubbingProxy_EdgeFeatureHubConfig
    public typealias Verification = __VerificationProxy_EdgeFeatureHubConfig

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: EdgeFeatureHubConfig?

    public func enableDefaultImplementation(_ stub: EdgeFeatureHubConfig) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
    public override var _apiKeys: [String] {
        get {
            return cuckoo_manager.getter("_apiKeys",
                superclassCall:
                    
                    super._apiKeys
                    ,
                defaultCall: __defaultImplStub!._apiKeys)
        }
        
        set {
            cuckoo_manager.setter("_apiKeys",
                value: newValue,
                superclassCall:
                    
                    super._apiKeys = newValue
                    ,
                defaultCall: __defaultImplStub!._apiKeys = newValue)
        }
        
    }
    
    
    
    
    
    public override var _baseUrl: String {
        get {
            return cuckoo_manager.getter("_baseUrl",
                superclassCall:
                    
                    super._baseUrl
                    ,
                defaultCall: __defaultImplStub!._baseUrl)
        }
        
        set {
            cuckoo_manager.setter("_baseUrl",
                value: newValue,
                superclassCall:
                    
                    super._baseUrl = newValue
                    ,
                defaultCall: __defaultImplStub!._baseUrl = newValue)
        }
        
    }
    
    
    
    
    
    public override var _featuresUrl: String {
        get {
            return cuckoo_manager.getter("_featuresUrl",
                superclassCall:
                    
                    super._featuresUrl
                    ,
                defaultCall: __defaultImplStub!._featuresUrl)
        }
        
        set {
            cuckoo_manager.setter("_featuresUrl",
                value: newValue,
                superclassCall:
                    
                    super._featuresUrl = newValue
                    ,
                defaultCall: __defaultImplStub!._featuresUrl = newValue)
        }
        
    }
    
    
    
    
    
    public override var edgeProvider: (_ repo: InternalFeatureRepository, _ config: FeatureHubConfig) -> EdgeService {
        get {
            return cuckoo_manager.getter("edgeProvider",
                superclassCall:
                    
                    super.edgeProvider
                    ,
                defaultCall: __defaultImplStub!.edgeProvider)
        }
        
        set {
            cuckoo_manager.setter("edgeProvider",
                value: newValue,
                superclassCall:
                    
                    super.edgeProvider = newValue
                    ,
                defaultCall: __defaultImplStub!.edgeProvider = newValue)
        }
        
    }
    
    
    
    
    
    public override var _repo: Repository? {
        get {
            return cuckoo_manager.getter("_repo",
                superclassCall:
                    
                    super._repo
                    ,
                defaultCall: __defaultImplStub!._repo)
        }
        
        set {
            cuckoo_manager.setter("_repo",
                value: newValue,
                superclassCall:
                    
                    super._repo = newValue
                    ,
                defaultCall: __defaultImplStub!._repo = newValue)
        }
        
    }
    
    
    
    
    
    public override var _serverContext: ClientContext? {
        get {
            return cuckoo_manager.getter("_serverContext",
                superclassCall:
                    
                    super._serverContext
                    ,
                defaultCall: __defaultImplStub!._serverContext)
        }
        
        set {
            cuckoo_manager.setter("_serverContext",
                value: newValue,
                superclassCall:
                    
                    super._serverContext = newValue
                    ,
                defaultCall: __defaultImplStub!._serverContext = newValue)
        }
        
    }
    
    
    
    
    
    public override var _edge: EdgeService? {
        get {
            return cuckoo_manager.getter("_edge",
                superclassCall:
                    
                    super._edge
                    ,
                defaultCall: __defaultImplStub!._edge)
        }
        
        set {
            cuckoo_manager.setter("_edge",
                value: newValue,
                superclassCall:
                    
                    super._edge = newValue
                    ,
                defaultCall: __defaultImplStub!._edge = newValue)
        }
        
    }
    
    
    
    
    
    public override var apiKeys: [String] {
        get {
            return cuckoo_manager.getter("apiKeys",
                superclassCall:
                    
                    super.apiKeys
                    ,
                defaultCall: __defaultImplStub!.apiKeys)
        }
        
    }
    
    
    
    
    
    public override var baseUrl: String {
        get {
            return cuckoo_manager.getter("baseUrl",
                superclassCall:
                    
                    super.baseUrl
                    ,
                defaultCall: __defaultImplStub!.baseUrl)
        }
        
    }
    
    
    
    
    
    public override var featuresUrl: String {
        get {
            return cuckoo_manager.getter("featuresUrl",
                superclassCall:
                    
                    super.featuresUrl
                    ,
                defaultCall: __defaultImplStub!.featuresUrl)
        }
        
    }
    
    
    
    
    
    public override var clientEval: Bool {
        get {
            return cuckoo_manager.getter("clientEval",
                superclassCall:
                    
                    super.clientEval
                    ,
                defaultCall: __defaultImplStub!.clientEval)
        }
        
    }
    
    
    
    
    
    public override var repository: FeatureRepository {
        get {
            return cuckoo_manager.getter("repository",
                superclassCall:
                    
                    super.repository
                    ,
                defaultCall: __defaultImplStub!.repository)
        }
        
    }
    
    

    

    
    
    
    
    public override func useRest(_ timeoutInSeconds: Int)  {
        
    return cuckoo_manager.call(
    """
    useRest(_: Int)
    """,
            parameters: (timeoutInSeconds),
            escapingParameters: (timeoutInSeconds),
            superclassCall:
                
                super.useRest(timeoutInSeconds)
                ,
            defaultCall: __defaultImplStub!.useRest(timeoutInSeconds))
        
    }
    
    
    
    
    
    public override func useRest(_ timeoutInSeconds: Int, requestor: FeatureRequestor)  {
        
    return cuckoo_manager.call(
    """
    useRest(_: Int, requestor: FeatureRequestor)
    """,
            parameters: (timeoutInSeconds, requestor),
            escapingParameters: (timeoutInSeconds, requestor),
            superclassCall:
                
                super.useRest(timeoutInSeconds, requestor: requestor)
                ,
            defaultCall: __defaultImplStub!.useRest(timeoutInSeconds, requestor: requestor))
        
    }
    
    
    
    
    
    public override func newContext() -> ClientContext {
        
    return cuckoo_manager.call(
    """
    newContext() -> ClientContext
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.newContext()
                ,
            defaultCall: __defaultImplStub!.newContext())
        
    }
    
    
    
    
    
    public override func start() -> ClientContext {
        
    return cuckoo_manager.call(
    """
    start() -> ClientContext
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.start()
                ,
            defaultCall: __defaultImplStub!.start())
        
    }
    
    
    
    
    
    public override func useStreaming()  {
        
    return cuckoo_manager.call(
    """
    useStreaming()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.useStreaming()
                ,
            defaultCall: __defaultImplStub!.useStreaming())
        
    }
    
    

    public struct __StubbingProxy_EdgeFeatureHubConfig: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var _apiKeys: Cuckoo.ClassToBeStubbedProperty<MockEdgeFeatureHubConfig, [String]> {
            return .init(manager: cuckoo_manager, name: "_apiKeys")
        }
        
        
        
        
        var _baseUrl: Cuckoo.ClassToBeStubbedProperty<MockEdgeFeatureHubConfig, String> {
            return .init(manager: cuckoo_manager, name: "_baseUrl")
        }
        
        
        
        
        var _featuresUrl: Cuckoo.ClassToBeStubbedProperty<MockEdgeFeatureHubConfig, String> {
            return .init(manager: cuckoo_manager, name: "_featuresUrl")
        }
        
        
        
        
        var edgeProvider: Cuckoo.ClassToBeStubbedProperty<MockEdgeFeatureHubConfig, (_ repo: InternalFeatureRepository, _ config: FeatureHubConfig) -> EdgeService> {
            return .init(manager: cuckoo_manager, name: "edgeProvider")
        }
        
        
        
        
        var _repo: Cuckoo.ClassToBeStubbedOptionalProperty<MockEdgeFeatureHubConfig, Repository> {
            return .init(manager: cuckoo_manager, name: "_repo")
        }
        
        
        
        
        var _serverContext: Cuckoo.ClassToBeStubbedOptionalProperty<MockEdgeFeatureHubConfig, ClientContext> {
            return .init(manager: cuckoo_manager, name: "_serverContext")
        }
        
        
        
        
        var _edge: Cuckoo.ClassToBeStubbedOptionalProperty<MockEdgeFeatureHubConfig, EdgeService> {
            return .init(manager: cuckoo_manager, name: "_edge")
        }
        
        
        
        
        var apiKeys: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockEdgeFeatureHubConfig, [String]> {
            return .init(manager: cuckoo_manager, name: "apiKeys")
        }
        
        
        
        
        var baseUrl: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockEdgeFeatureHubConfig, String> {
            return .init(manager: cuckoo_manager, name: "baseUrl")
        }
        
        
        
        
        var featuresUrl: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockEdgeFeatureHubConfig, String> {
            return .init(manager: cuckoo_manager, name: "featuresUrl")
        }
        
        
        
        
        var clientEval: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockEdgeFeatureHubConfig, Bool> {
            return .init(manager: cuckoo_manager, name: "clientEval")
        }
        
        
        
        
        var repository: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockEdgeFeatureHubConfig, FeatureRepository> {
            return .init(manager: cuckoo_manager, name: "repository")
        }
        
        
        
        
        
        func useRest<M1: Cuckoo.Matchable>(_ timeoutInSeconds: M1) -> Cuckoo.ClassStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: timeoutInSeconds) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEdgeFeatureHubConfig.self, method:
    """
    useRest(_: Int)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func useRest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ timeoutInSeconds: M1, requestor: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, FeatureRequestor)> where M1.MatchedType == Int, M2.MatchedType == FeatureRequestor {
            let matchers: [Cuckoo.ParameterMatcher<(Int, FeatureRequestor)>] = [wrap(matchable: timeoutInSeconds) { $0.0 }, wrap(matchable: requestor) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEdgeFeatureHubConfig.self, method:
    """
    useRest(_: Int, requestor: FeatureRequestor)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func newContext() -> Cuckoo.ClassStubFunction<(), ClientContext> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEdgeFeatureHubConfig.self, method:
    """
    newContext() -> ClientContext
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func start() -> Cuckoo.ClassStubFunction<(), ClientContext> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEdgeFeatureHubConfig.self, method:
    """
    start() -> ClientContext
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func useStreaming() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEdgeFeatureHubConfig.self, method:
    """
    useStreaming()
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_EdgeFeatureHubConfig: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var _apiKeys: Cuckoo.VerifyProperty<[String]> {
            return .init(manager: cuckoo_manager, name: "_apiKeys", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _baseUrl: Cuckoo.VerifyProperty<String> {
            return .init(manager: cuckoo_manager, name: "_baseUrl", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _featuresUrl: Cuckoo.VerifyProperty<String> {
            return .init(manager: cuckoo_manager, name: "_featuresUrl", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var edgeProvider: Cuckoo.VerifyProperty<(_ repo: InternalFeatureRepository, _ config: FeatureHubConfig) -> EdgeService> {
            return .init(manager: cuckoo_manager, name: "edgeProvider", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _repo: Cuckoo.VerifyOptionalProperty<Repository> {
            return .init(manager: cuckoo_manager, name: "_repo", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _serverContext: Cuckoo.VerifyOptionalProperty<ClientContext> {
            return .init(manager: cuckoo_manager, name: "_serverContext", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _edge: Cuckoo.VerifyOptionalProperty<EdgeService> {
            return .init(manager: cuckoo_manager, name: "_edge", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var apiKeys: Cuckoo.VerifyReadOnlyProperty<[String]> {
            return .init(manager: cuckoo_manager, name: "apiKeys", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var baseUrl: Cuckoo.VerifyReadOnlyProperty<String> {
            return .init(manager: cuckoo_manager, name: "baseUrl", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var featuresUrl: Cuckoo.VerifyReadOnlyProperty<String> {
            return .init(manager: cuckoo_manager, name: "featuresUrl", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var clientEval: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "clientEval", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var repository: Cuckoo.VerifyReadOnlyProperty<FeatureRepository> {
            return .init(manager: cuckoo_manager, name: "repository", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func useRest<M1: Cuckoo.Matchable>(_ timeoutInSeconds: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: timeoutInSeconds) { $0 }]
            return cuckoo_manager.verify(
    """
    useRest(_: Int)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func useRest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ timeoutInSeconds: M1, requestor: M2) -> Cuckoo.__DoNotUse<(Int, FeatureRequestor), Void> where M1.MatchedType == Int, M2.MatchedType == FeatureRequestor {
            let matchers: [Cuckoo.ParameterMatcher<(Int, FeatureRequestor)>] = [wrap(matchable: timeoutInSeconds) { $0.0 }, wrap(matchable: requestor) { $0.1 }]
            return cuckoo_manager.verify(
    """
    useRest(_: Int, requestor: FeatureRequestor)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func newContext() -> Cuckoo.__DoNotUse<(), ClientContext> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    newContext() -> ClientContext
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func start() -> Cuckoo.__DoNotUse<(), ClientContext> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    start() -> ClientContext
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func useStreaming() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    useStreaming()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class EdgeFeatureHubConfigStub: EdgeFeatureHubConfig {
    
    
    
    
    public override var _apiKeys: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
        set { }
        
    }
    
    
    
    
    
    public override var _baseUrl: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
        set { }
        
    }
    
    
    
    
    
    public override var _featuresUrl: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
        set { }
        
    }
    
    
    
    
    
    public override var edgeProvider: (_ repo: InternalFeatureRepository, _ config: FeatureHubConfig) -> EdgeService {
        get {
            return DefaultValueRegistry.defaultValue(for: (( InternalFeatureRepository,  FeatureHubConfig) -> EdgeService).self)
        }
        
        set { }
        
    }
    
    
    
    
    
    public override var _repo: Repository? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Repository?).self)
        }
        
        set { }
        
    }
    
    
    
    
    
    public override var _serverContext: ClientContext? {
        get {
            return DefaultValueRegistry.defaultValue(for: (ClientContext?).self)
        }
        
        set { }
        
    }
    
    
    
    
    
    public override var _edge: EdgeService? {
        get {
            return DefaultValueRegistry.defaultValue(for: (EdgeService?).self)
        }
        
        set { }
        
    }
    
    
    
    
    
    public override var apiKeys: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
    
    
    
    public override var baseUrl: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    
    
    
    public override var featuresUrl: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    
    
    
    public override var clientEval: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
    
    
    
    public override var repository: FeatureRepository {
        get {
            return DefaultValueRegistry.defaultValue(for: (FeatureRepository).self)
        }
        
    }
    
    

    

    
    
    
    
    public override func useRest(_ timeoutInSeconds: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public override func useRest(_ timeoutInSeconds: Int, requestor: FeatureRequestor)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public override func newContext() -> ClientContext  {
        return DefaultValueRegistry.defaultValue(for: (ClientContext).self)
    }
    
    
    
    
    
    public override func start() -> ClientContext  {
        return DefaultValueRegistry.defaultValue(for: (ClientContext).self)
    }
    
    
    
    
    
    public override func useStreaming()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Sources/featurehub-swift-sdk/featurehub_swift_sdk.swift at 2023-03-14 08:42:49 +0000


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
    
    

    

    
    
    
    
    public func feature(_ key: String) -> RepositoryFeatureState {
        
    return cuckoo_manager.call(
    """
    feature(_: String) -> RepositoryFeatureState
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
        
        
        
        
        
        func feature<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ProtocolStubFunction<(String), RepositoryFeatureState> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFeatureRepository.self, method:
    """
    feature(_: String) -> RepositoryFeatureState
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
        func feature<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), RepositoryFeatureState> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return cuckoo_manager.verify(
    """
    feature(_: String) -> RepositoryFeatureState
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
    
    

    

    
    
    
    
    public func feature(_ key: String) -> RepositoryFeatureState  {
        return DefaultValueRegistry.defaultValue(for: (RepositoryFeatureState).self)
    }
    
    
    
    
    
    public func registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Sources/featurehub-swift-sdk/features.swift at 2023-03-14 08:42:49 +0000


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
    
    
    
    
    
    public var number: Double? {
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
        
        
        
        
        var number: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRepositoryFeatureState, Double?> {
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
        
        
        
        
        var number: Cuckoo.VerifyReadOnlyProperty<Double?> {
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
    
    
    
    
    
    public var number: Double? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Double?).self)
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





// MARK: - Mocks generated from file: Sources/featurehub-swift-sdk/internal/internal_repository.swift at 2023-03-14 08:42:49 +0000


import Cuckoo
@testable import featurehub_swift_sdk

import Foundation






 class MockInternalFeatureRepository: InternalFeatureRepository, Cuckoo.ProtocolMock {
    
     typealias MocksType = InternalFeatureRepository
    
     typealias Stubbing = __StubbingProxy_InternalFeatureRepository
     typealias Verification = __VerificationProxy_InternalFeatureRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: InternalFeatureRepository?

     func enableDefaultImplementation(_ stub: InternalFeatureRepository) {
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
    
    

    

    
    
    
    
     func empty()  {
        
    return cuckoo_manager.call(
    """
    empty()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.empty())
        
    }
    
    
    
    
    
     func feat(_ key: String) -> FeatureStateHolder? {
        
    return cuckoo_manager.call(
    """
    feat(_: String) -> FeatureStateHolder?
    """,
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.feat(key))
        
    }
    
    
    
    
    
     func findInterceptor(_ key: String) -> InterceptorValue? {
        
    return cuckoo_manager.call(
    """
    findInterceptor(_: String) -> InterceptorValue?
    """,
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.findInterceptor(key))
        
    }
    
    
    
    
    
     func notReady()  {
        
    return cuckoo_manager.call(
    """
    notReady()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.notReady())
        
    }
    
    
    
    
    
     func apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue {
        
    return cuckoo_manager.call(
    """
    apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue
    """,
            parameters: (strategies, key, featureId, context),
            escapingParameters: (strategies, key, featureId, context),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.apply(strategies: strategies, key: key, featureId: featureId, context: context))
        
    }
    
    
    
    
    
     func updateFeatures(_ features: [FeatureState])  {
        
    return cuckoo_manager.call(
    """
    updateFeatures(_: [FeatureState])
    """,
            parameters: (features),
            escapingParameters: (features),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.updateFeatures(features))
        
    }
    
    
    
    
    
     func updateFeature(_ state: FeatureState)  {
        
    return cuckoo_manager.call(
    """
    updateFeature(_: FeatureState)
    """,
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.updateFeature(state))
        
    }
    
    
    
    
    
     func deleteFeature(_ feature: FeatureState)  {
        
    return cuckoo_manager.call(
    """
    deleteFeature(_: FeatureState)
    """,
            parameters: (feature),
            escapingParameters: (feature),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.deleteFeature(feature))
        
    }
    
    
    
    
    
     func notify(status: SSEResultState?)  {
        
    return cuckoo_manager.call(
    """
    notify(status: SSEResultState?)
    """,
            parameters: (status),
            escapingParameters: (status),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.notify(status: status))
        
    }
    
    
    
    
    
    public func feature(_ key: String) -> RepositoryFeatureState {
        
    return cuckoo_manager.call(
    """
    feature(_: String) -> RepositoryFeatureState
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
    
    

     struct __StubbingProxy_InternalFeatureRepository: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var readiness: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockInternalFeatureRepository, Readiness> {
            return .init(manager: cuckoo_manager, name: "readiness")
        }
        
        
        
        
        
        func empty() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    empty()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func feat<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ProtocolStubFunction<(String), FeatureStateHolder?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    feat(_: String) -> FeatureStateHolder?
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func findInterceptor<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ProtocolStubFunction<(String), InterceptorValue?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    findInterceptor(_: String) -> InterceptorValue?
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func notReady() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    notReady()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func apply<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(strategies: M1, key: M2, featureId: M3, context: M4) -> Cuckoo.ProtocolStubFunction<([FeatureRolloutStrategy], String, UUID, ClientContext?), AppliedValue> where M1.MatchedType == [FeatureRolloutStrategy], M2.MatchedType == String, M3.MatchedType == UUID, M4.OptionalMatchedType == ClientContext {
            let matchers: [Cuckoo.ParameterMatcher<([FeatureRolloutStrategy], String, UUID, ClientContext?)>] = [wrap(matchable: strategies) { $0.0 }, wrap(matchable: key) { $0.1 }, wrap(matchable: featureId) { $0.2 }, wrap(matchable: context) { $0.3 }]
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func updateFeatures<M1: Cuckoo.Matchable>(_ features: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([FeatureState])> where M1.MatchedType == [FeatureState] {
            let matchers: [Cuckoo.ParameterMatcher<([FeatureState])>] = [wrap(matchable: features) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    updateFeatures(_: [FeatureState])
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func updateFeature<M1: Cuckoo.Matchable>(_ state: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(FeatureState)> where M1.MatchedType == FeatureState {
            let matchers: [Cuckoo.ParameterMatcher<(FeatureState)>] = [wrap(matchable: state) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    updateFeature(_: FeatureState)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func deleteFeature<M1: Cuckoo.Matchable>(_ feature: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(FeatureState)> where M1.MatchedType == FeatureState {
            let matchers: [Cuckoo.ParameterMatcher<(FeatureState)>] = [wrap(matchable: feature) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    deleteFeature(_: FeatureState)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func notify<M1: Cuckoo.OptionalMatchable>(status: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(SSEResultState?)> where M1.OptionalMatchedType == SSEResultState {
            let matchers: [Cuckoo.ParameterMatcher<(SSEResultState?)>] = [wrap(matchable: status) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    notify(status: SSEResultState?)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func feature<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ProtocolStubFunction<(String), RepositoryFeatureState> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    feature(_: String) -> RepositoryFeatureState
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func registerFeatureValueInterceptor<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(allowOverrideLock: M1, interceptor: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Bool, FeatureValueInterceptor)> where M1.MatchedType == Bool, M2.MatchedType == FeatureValueInterceptor {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, FeatureValueInterceptor)>] = [wrap(matchable: allowOverrideLock) { $0.0 }, wrap(matchable: interceptor) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockInternalFeatureRepository.self, method:
    """
    registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_InternalFeatureRepository: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var readiness: Cuckoo.VerifyReadOnlyProperty<Readiness> {
            return .init(manager: cuckoo_manager, name: "readiness", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func empty() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    empty()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func feat<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), FeatureStateHolder?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return cuckoo_manager.verify(
    """
    feat(_: String) -> FeatureStateHolder?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func findInterceptor<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), InterceptorValue?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return cuckoo_manager.verify(
    """
    findInterceptor(_: String) -> InterceptorValue?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func notReady() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    notReady()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func apply<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(strategies: M1, key: M2, featureId: M3, context: M4) -> Cuckoo.__DoNotUse<([FeatureRolloutStrategy], String, UUID, ClientContext?), AppliedValue> where M1.MatchedType == [FeatureRolloutStrategy], M2.MatchedType == String, M3.MatchedType == UUID, M4.OptionalMatchedType == ClientContext {
            let matchers: [Cuckoo.ParameterMatcher<([FeatureRolloutStrategy], String, UUID, ClientContext?)>] = [wrap(matchable: strategies) { $0.0 }, wrap(matchable: key) { $0.1 }, wrap(matchable: featureId) { $0.2 }, wrap(matchable: context) { $0.3 }]
            return cuckoo_manager.verify(
    """
    apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func updateFeatures<M1: Cuckoo.Matchable>(_ features: M1) -> Cuckoo.__DoNotUse<([FeatureState]), Void> where M1.MatchedType == [FeatureState] {
            let matchers: [Cuckoo.ParameterMatcher<([FeatureState])>] = [wrap(matchable: features) { $0 }]
            return cuckoo_manager.verify(
    """
    updateFeatures(_: [FeatureState])
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func updateFeature<M1: Cuckoo.Matchable>(_ state: M1) -> Cuckoo.__DoNotUse<(FeatureState), Void> where M1.MatchedType == FeatureState {
            let matchers: [Cuckoo.ParameterMatcher<(FeatureState)>] = [wrap(matchable: state) { $0 }]
            return cuckoo_manager.verify(
    """
    updateFeature(_: FeatureState)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func deleteFeature<M1: Cuckoo.Matchable>(_ feature: M1) -> Cuckoo.__DoNotUse<(FeatureState), Void> where M1.MatchedType == FeatureState {
            let matchers: [Cuckoo.ParameterMatcher<(FeatureState)>] = [wrap(matchable: feature) { $0 }]
            return cuckoo_manager.verify(
    """
    deleteFeature(_: FeatureState)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func notify<M1: Cuckoo.OptionalMatchable>(status: M1) -> Cuckoo.__DoNotUse<(SSEResultState?), Void> where M1.OptionalMatchedType == SSEResultState {
            let matchers: [Cuckoo.ParameterMatcher<(SSEResultState?)>] = [wrap(matchable: status) { $0 }]
            return cuckoo_manager.verify(
    """
    notify(status: SSEResultState?)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func feature<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), RepositoryFeatureState> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return cuckoo_manager.verify(
    """
    feature(_: String) -> RepositoryFeatureState
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


 class InternalFeatureRepositoryStub: InternalFeatureRepository {
    
    
    
    
    public var readiness: Readiness {
        get {
            return DefaultValueRegistry.defaultValue(for: (Readiness).self)
        }
        
    }
    
    

    

    
    
    
    
     func empty()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func feat(_ key: String) -> FeatureStateHolder?  {
        return DefaultValueRegistry.defaultValue(for: (FeatureStateHolder?).self)
    }
    
    
    
    
    
     func findInterceptor(_ key: String) -> InterceptorValue?  {
        return DefaultValueRegistry.defaultValue(for: (InterceptorValue?).self)
    }
    
    
    
    
    
     func notReady()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue  {
        return DefaultValueRegistry.defaultValue(for: (AppliedValue).self)
    }
    
    
    
    
    
     func updateFeatures(_ features: [FeatureState])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func updateFeature(_ state: FeatureState)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func deleteFeature(_ feature: FeatureState)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func notify(status: SSEResultState?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func feature(_ key: String) -> RepositoryFeatureState  {
        return DefaultValueRegistry.defaultValue(for: (RepositoryFeatureState).self)
    }
    
    
    
    
    
    public func registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}










public class MockFeatureValueInterceptor: FeatureValueInterceptor, Cuckoo.ProtocolMock {
    
    public typealias MocksType = FeatureValueInterceptor
    
    public typealias Stubbing = __StubbingProxy_FeatureValueInterceptor
    public typealias Verification = __VerificationProxy_FeatureValueInterceptor

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FeatureValueInterceptor?

    public func enableDefaultImplementation(_ stub: FeatureValueInterceptor) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
    public func match(_ key: String) -> InterceptorValue? {
        
    return cuckoo_manager.call(
    """
    match(_: String) -> InterceptorValue?
    """,
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.match(key))
        
    }
    
    

    public struct __StubbingProxy_FeatureValueInterceptor: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func match<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ProtocolStubFunction<(String), InterceptorValue?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFeatureValueInterceptor.self, method:
    """
    match(_: String) -> InterceptorValue?
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_FeatureValueInterceptor: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func match<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), InterceptorValue?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return cuckoo_manager.verify(
    """
    match(_: String) -> InterceptorValue?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class FeatureValueInterceptorStub: FeatureValueInterceptor {
    

    

    
    
    
    
    public func match(_ key: String) -> InterceptorValue?  {
        return DefaultValueRegistry.defaultValue(for: (InterceptorValue?).self)
    }
    
    
}










 class MockValueInterceptor: ValueInterceptor, Cuckoo.ClassMock {
    
     typealias MocksType = ValueInterceptor
    
     typealias Stubbing = __StubbingProxy_ValueInterceptor
     typealias Verification = __VerificationProxy_ValueInterceptor

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ValueInterceptor?

     func enableDefaultImplementation(_ stub: ValueInterceptor) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    

     struct __StubbingProxy_ValueInterceptor: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
    }

     struct __VerificationProxy_ValueInterceptor: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
    }
}


 class ValueInterceptorStub: ValueInterceptor {
    

    

    
}










 class MockRepository: Repository, Cuckoo.ClassMock {
    
     typealias MocksType = Repository
    
     typealias Stubbing = __StubbingProxy_Repository
     typealias Verification = __VerificationProxy_Repository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: Repository?

     func enableDefaultImplementation(_ stub: Repository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
     override var readiness: Readiness {
        get {
            return cuckoo_manager.getter("readiness",
                superclassCall:
                    
                    super.readiness
                    ,
                defaultCall: __defaultImplStub!.readiness)
        }
        
    }
    
    

    

    
    
    
    
     override func registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)  {
        
    return cuckoo_manager.call(
    """
    registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)
    """,
            parameters: (allowOverrideLock, interceptor),
            escapingParameters: (allowOverrideLock, interceptor),
            superclassCall:
                
                super.registerFeatureValueInterceptor(allowOverrideLock: allowOverrideLock, interceptor: interceptor)
                ,
            defaultCall: __defaultImplStub!.registerFeatureValueInterceptor(allowOverrideLock: allowOverrideLock, interceptor: interceptor))
        
    }
    
    
    
    
    
     override func feat(_ key: String) -> FeatureStateHolder? {
        
    return cuckoo_manager.call(
    """
    feat(_: String) -> FeatureStateHolder?
    """,
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                super.feat(key)
                ,
            defaultCall: __defaultImplStub!.feat(key))
        
    }
    
    
    
    
    
     override func findInterceptor(_ key: String) -> InterceptorValue? {
        
    return cuckoo_manager.call(
    """
    findInterceptor(_: String) -> InterceptorValue?
    """,
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                super.findInterceptor(key)
                ,
            defaultCall: __defaultImplStub!.findInterceptor(key))
        
    }
    
    
    
    
    
     override func notReady()  {
        
    return cuckoo_manager.call(
    """
    notReady()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.notReady()
                ,
            defaultCall: __defaultImplStub!.notReady())
        
    }
    
    
    
    
    
     override func apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue {
        
    return cuckoo_manager.call(
    """
    apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue
    """,
            parameters: (strategies, key, featureId, context),
            escapingParameters: (strategies, key, featureId, context),
            superclassCall:
                
                super.apply(strategies: strategies, key: key, featureId: featureId, context: context)
                ,
            defaultCall: __defaultImplStub!.apply(strategies: strategies, key: key, featureId: featureId, context: context))
        
    }
    
    
    
    
    
     override func notify(status: SSEResultState?)  {
        
    return cuckoo_manager.call(
    """
    notify(status: SSEResultState?)
    """,
            parameters: (status),
            escapingParameters: (status),
            superclassCall:
                
                super.notify(status: status)
                ,
            defaultCall: __defaultImplStub!.notify(status: status))
        
    }
    
    
    
    
    
     override func updateFeatures(_ features: [FeatureState])  {
        
    return cuckoo_manager.call(
    """
    updateFeatures(_: [FeatureState])
    """,
            parameters: (features),
            escapingParameters: (features),
            superclassCall:
                
                super.updateFeatures(features)
                ,
            defaultCall: __defaultImplStub!.updateFeatures(features))
        
    }
    
    
    
    
    
     override func updateFeature(_ state: FeatureState)  {
        
    return cuckoo_manager.call(
    """
    updateFeature(_: FeatureState)
    """,
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                super.updateFeature(state)
                ,
            defaultCall: __defaultImplStub!.updateFeature(state))
        
    }
    
    
    
    
    
     override func deleteFeature(_ feature: FeatureState)  {
        
    return cuckoo_manager.call(
    """
    deleteFeature(_: FeatureState)
    """,
            parameters: (feature),
            escapingParameters: (feature),
            superclassCall:
                
                super.deleteFeature(feature)
                ,
            defaultCall: __defaultImplStub!.deleteFeature(feature))
        
    }
    
    
    
    
    
     override func feature(_ key: String) -> RepositoryFeatureState {
        
    return cuckoo_manager.call(
    """
    feature(_: String) -> RepositoryFeatureState
    """,
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                super.feature(key)
                ,
            defaultCall: __defaultImplStub!.feature(key))
        
    }
    
    
    
    
    
     override func empty()  {
        
    return cuckoo_manager.call(
    """
    empty()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.empty()
                ,
            defaultCall: __defaultImplStub!.empty())
        
    }
    
    

     struct __StubbingProxy_Repository: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var readiness: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockRepository, Readiness> {
            return .init(manager: cuckoo_manager, name: "readiness")
        }
        
        
        
        
        
        func registerFeatureValueInterceptor<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(allowOverrideLock: M1, interceptor: M2) -> Cuckoo.ClassStubNoReturnFunction<(Bool, FeatureValueInterceptor)> where M1.MatchedType == Bool, M2.MatchedType == FeatureValueInterceptor {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, FeatureValueInterceptor)>] = [wrap(matchable: allowOverrideLock) { $0.0 }, wrap(matchable: interceptor) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func feat<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ClassStubFunction<(String), FeatureStateHolder?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    feat(_: String) -> FeatureStateHolder?
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func findInterceptor<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ClassStubFunction<(String), InterceptorValue?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    findInterceptor(_: String) -> InterceptorValue?
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func notReady() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    notReady()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func apply<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(strategies: M1, key: M2, featureId: M3, context: M4) -> Cuckoo.ClassStubFunction<([FeatureRolloutStrategy], String, UUID, ClientContext?), AppliedValue> where M1.MatchedType == [FeatureRolloutStrategy], M2.MatchedType == String, M3.MatchedType == UUID, M4.OptionalMatchedType == ClientContext {
            let matchers: [Cuckoo.ParameterMatcher<([FeatureRolloutStrategy], String, UUID, ClientContext?)>] = [wrap(matchable: strategies) { $0.0 }, wrap(matchable: key) { $0.1 }, wrap(matchable: featureId) { $0.2 }, wrap(matchable: context) { $0.3 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func notify<M1: Cuckoo.OptionalMatchable>(status: M1) -> Cuckoo.ClassStubNoReturnFunction<(SSEResultState?)> where M1.OptionalMatchedType == SSEResultState {
            let matchers: [Cuckoo.ParameterMatcher<(SSEResultState?)>] = [wrap(matchable: status) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    notify(status: SSEResultState?)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func updateFeatures<M1: Cuckoo.Matchable>(_ features: M1) -> Cuckoo.ClassStubNoReturnFunction<([FeatureState])> where M1.MatchedType == [FeatureState] {
            let matchers: [Cuckoo.ParameterMatcher<([FeatureState])>] = [wrap(matchable: features) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    updateFeatures(_: [FeatureState])
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func updateFeature<M1: Cuckoo.Matchable>(_ state: M1) -> Cuckoo.ClassStubNoReturnFunction<(FeatureState)> where M1.MatchedType == FeatureState {
            let matchers: [Cuckoo.ParameterMatcher<(FeatureState)>] = [wrap(matchable: state) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    updateFeature(_: FeatureState)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func deleteFeature<M1: Cuckoo.Matchable>(_ feature: M1) -> Cuckoo.ClassStubNoReturnFunction<(FeatureState)> where M1.MatchedType == FeatureState {
            let matchers: [Cuckoo.ParameterMatcher<(FeatureState)>] = [wrap(matchable: feature) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    deleteFeature(_: FeatureState)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func feature<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ClassStubFunction<(String), RepositoryFeatureState> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    feature(_: String) -> RepositoryFeatureState
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func empty() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRepository.self, method:
    """
    empty()
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_Repository: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var readiness: Cuckoo.VerifyReadOnlyProperty<Readiness> {
            return .init(manager: cuckoo_manager, name: "readiness", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func registerFeatureValueInterceptor<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(allowOverrideLock: M1, interceptor: M2) -> Cuckoo.__DoNotUse<(Bool, FeatureValueInterceptor), Void> where M1.MatchedType == Bool, M2.MatchedType == FeatureValueInterceptor {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, FeatureValueInterceptor)>] = [wrap(matchable: allowOverrideLock) { $0.0 }, wrap(matchable: interceptor) { $0.1 }]
            return cuckoo_manager.verify(
    """
    registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func feat<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), FeatureStateHolder?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return cuckoo_manager.verify(
    """
    feat(_: String) -> FeatureStateHolder?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func findInterceptor<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), InterceptorValue?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return cuckoo_manager.verify(
    """
    findInterceptor(_: String) -> InterceptorValue?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func notReady() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    notReady()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func apply<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(strategies: M1, key: M2, featureId: M3, context: M4) -> Cuckoo.__DoNotUse<([FeatureRolloutStrategy], String, UUID, ClientContext?), AppliedValue> where M1.MatchedType == [FeatureRolloutStrategy], M2.MatchedType == String, M3.MatchedType == UUID, M4.OptionalMatchedType == ClientContext {
            let matchers: [Cuckoo.ParameterMatcher<([FeatureRolloutStrategy], String, UUID, ClientContext?)>] = [wrap(matchable: strategies) { $0.0 }, wrap(matchable: key) { $0.1 }, wrap(matchable: featureId) { $0.2 }, wrap(matchable: context) { $0.3 }]
            return cuckoo_manager.verify(
    """
    apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func notify<M1: Cuckoo.OptionalMatchable>(status: M1) -> Cuckoo.__DoNotUse<(SSEResultState?), Void> where M1.OptionalMatchedType == SSEResultState {
            let matchers: [Cuckoo.ParameterMatcher<(SSEResultState?)>] = [wrap(matchable: status) { $0 }]
            return cuckoo_manager.verify(
    """
    notify(status: SSEResultState?)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func updateFeatures<M1: Cuckoo.Matchable>(_ features: M1) -> Cuckoo.__DoNotUse<([FeatureState]), Void> where M1.MatchedType == [FeatureState] {
            let matchers: [Cuckoo.ParameterMatcher<([FeatureState])>] = [wrap(matchable: features) { $0 }]
            return cuckoo_manager.verify(
    """
    updateFeatures(_: [FeatureState])
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func updateFeature<M1: Cuckoo.Matchable>(_ state: M1) -> Cuckoo.__DoNotUse<(FeatureState), Void> where M1.MatchedType == FeatureState {
            let matchers: [Cuckoo.ParameterMatcher<(FeatureState)>] = [wrap(matchable: state) { $0 }]
            return cuckoo_manager.verify(
    """
    updateFeature(_: FeatureState)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func deleteFeature<M1: Cuckoo.Matchable>(_ feature: M1) -> Cuckoo.__DoNotUse<(FeatureState), Void> where M1.MatchedType == FeatureState {
            let matchers: [Cuckoo.ParameterMatcher<(FeatureState)>] = [wrap(matchable: feature) { $0 }]
            return cuckoo_manager.verify(
    """
    deleteFeature(_: FeatureState)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func feature<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), RepositoryFeatureState> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
            return cuckoo_manager.verify(
    """
    feature(_: String) -> RepositoryFeatureState
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func empty() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    empty()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class RepositoryStub: Repository {
    
    
    
    
     override var readiness: Readiness {
        get {
            return DefaultValueRegistry.defaultValue(for: (Readiness).self)
        }
        
    }
    
    

    

    
    
    
    
     override func registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func feat(_ key: String) -> FeatureStateHolder?  {
        return DefaultValueRegistry.defaultValue(for: (FeatureStateHolder?).self)
    }
    
    
    
    
    
     override func findInterceptor(_ key: String) -> InterceptorValue?  {
        return DefaultValueRegistry.defaultValue(for: (InterceptorValue?).self)
    }
    
    
    
    
    
     override func notReady()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func apply(strategies: [FeatureRolloutStrategy], key: String, featureId: UUID, context: ClientContext?) -> AppliedValue  {
        return DefaultValueRegistry.defaultValue(for: (AppliedValue).self)
    }
    
    
    
    
    
     override func notify(status: SSEResultState?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func updateFeatures(_ features: [FeatureState])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func updateFeature(_ state: FeatureState)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func deleteFeature(_ feature: FeatureState)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func feature(_ key: String) -> RepositoryFeatureState  {
        return DefaultValueRegistry.defaultValue(for: (RepositoryFeatureState).self)
    }
    
    
    
    
    
     override func empty()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Sources/featurehub-swift-sdk/internal/internal_usebase_edge.swift at 2023-03-14 08:42:49 +0000

///
/// FeatureHub: Usage based edge. This service holds an update interval
/// which can be overridden by the server. It requests state by calling the
/// GET api if the interval has expired.
///
/// This concept is based on the same one from the Dart API and is intended for Mobile usage.
///

import Cuckoo
@testable import featurehub_swift_sdk

import Foundation






 class MockFeatureRequestor: FeatureRequestor, Cuckoo.ProtocolMock {
    
     typealias MocksType = FeatureRequestor
    
     typealias Stubbing = __StubbingProxy_FeatureRequestor
     typealias Verification = __VerificationProxy_FeatureRequestor

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FeatureRequestor?

     func enableDefaultImplementation(_ stub: FeatureRequestor) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?) async -> Response<[FeatureEnvironmentCollection]>? {
        
    return await cuckoo_manager.call(
    """
    getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?) async -> Response<[FeatureEnvironmentCollection]>?
    """,
            parameters: (apiKeys, contextSha, etag),
            escapingParameters: (apiKeys, contextSha, etag),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.getFeatureStates(apiKeys: apiKeys, contextSha: contextSha, etag: etag))
        
    }
    
    

     struct __StubbingProxy_FeatureRequestor: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func getFeatureStates<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(apiKeys: M1, contextSha: M2, etag: M3) -> Cuckoo.ProtocolStubFunction<([String], String?, String?), Response<[FeatureEnvironmentCollection]>?> where M1.MatchedType == [String], M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<([String], String?, String?)>] = [wrap(matchable: apiKeys) { $0.0 }, wrap(matchable: contextSha) { $0.1 }, wrap(matchable: etag) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFeatureRequestor.self, method:
    """
    getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?) async -> Response<[FeatureEnvironmentCollection]>?
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_FeatureRequestor: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func getFeatureStates<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(apiKeys: M1, contextSha: M2, etag: M3) -> Cuckoo.__DoNotUse<([String], String?, String?), Response<[FeatureEnvironmentCollection]>?> where M1.MatchedType == [String], M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<([String], String?, String?)>] = [wrap(matchable: apiKeys) { $0.0 }, wrap(matchable: contextSha) { $0.1 }, wrap(matchable: etag) { $0.2 }]
            return cuckoo_manager.verify(
    """
    getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?) async -> Response<[FeatureEnvironmentCollection]>?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class FeatureRequestorStub: FeatureRequestor {
    

    

    
    
    
    
     func getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?) async -> Response<[FeatureEnvironmentCollection]>?  {
        return DefaultValueRegistry.defaultValue(for: (Response<[FeatureEnvironmentCollection]>?).self)
    }
    
    
}










 class MockUseBasedEdge: UseBasedEdge, Cuckoo.ClassMock {
    
     typealias MocksType = UseBasedEdge
    
     typealias Stubbing = __StubbingProxy_UseBasedEdge
     typealias Verification = __VerificationProxy_UseBasedEdge

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: UseBasedEdge?

     func enableDefaultImplementation(_ stub: UseBasedEdge) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
     override var _timeoutInSeconds: Double {
        get {
            return cuckoo_manager.getter("_timeoutInSeconds",
                superclassCall:
                    
                    super._timeoutInSeconds
                    ,
                defaultCall: __defaultImplStub!._timeoutInSeconds)
        }
        
        set {
            cuckoo_manager.setter("_timeoutInSeconds",
                value: newValue,
                superclassCall:
                    
                    super._timeoutInSeconds = newValue
                    ,
                defaultCall: __defaultImplStub!._timeoutInSeconds = newValue)
        }
        
    }
    
    
    
    
    
     override var _initialized: Bool {
        get {
            return cuckoo_manager.getter("_initialized",
                superclassCall:
                    
                    super._initialized
                    ,
                defaultCall: __defaultImplStub!._initialized)
        }
        
        set {
            cuckoo_manager.setter("_initialized",
                value: newValue,
                superclassCall:
                    
                    super._initialized = newValue
                    ,
                defaultCall: __defaultImplStub!._initialized = newValue)
        }
        
    }
    
    
    
    
    
     override var _stopped: Bool {
        get {
            return cuckoo_manager.getter("_stopped",
                superclassCall:
                    
                    super._stopped
                    ,
                defaultCall: __defaultImplStub!._stopped)
        }
        
        set {
            cuckoo_manager.setter("_stopped",
                value: newValue,
                superclassCall:
                    
                    super._stopped = newValue
                    ,
                defaultCall: __defaultImplStub!._stopped = newValue)
        }
        
    }
    
    
    
    
    
     override var _header: String? {
        get {
            return cuckoo_manager.getter("_header",
                superclassCall:
                    
                    super._header
                    ,
                defaultCall: __defaultImplStub!._header)
        }
        
        set {
            cuckoo_manager.setter("_header",
                value: newValue,
                superclassCall:
                    
                    super._header = newValue
                    ,
                defaultCall: __defaultImplStub!._header = newValue)
        }
        
    }
    
    
    
    
    
     override var _cacheTimeout: Date {
        get {
            return cuckoo_manager.getter("_cacheTimeout",
                superclassCall:
                    
                    super._cacheTimeout
                    ,
                defaultCall: __defaultImplStub!._cacheTimeout)
        }
        
        set {
            cuckoo_manager.setter("_cacheTimeout",
                value: newValue,
                superclassCall:
                    
                    super._cacheTimeout = newValue
                    ,
                defaultCall: __defaultImplStub!._cacheTimeout = newValue)
        }
        
    }
    
    
    
    
    
     override var _contextSha: String {
        get {
            return cuckoo_manager.getter("_contextSha",
                superclassCall:
                    
                    super._contextSha
                    ,
                defaultCall: __defaultImplStub!._contextSha)
        }
        
        set {
            cuckoo_manager.setter("_contextSha",
                value: newValue,
                superclassCall:
                    
                    super._contextSha = newValue
                    ,
                defaultCall: __defaultImplStub!._contextSha = newValue)
        }
        
    }
    
    
    
    
    
     override var _callActive: Bool {
        get {
            return cuckoo_manager.getter("_callActive",
                superclassCall:
                    
                    super._callActive
                    ,
                defaultCall: __defaultImplStub!._callActive)
        }
        
        set {
            cuckoo_manager.setter("_callActive",
                value: newValue,
                superclassCall:
                    
                    super._callActive = newValue
                    ,
                defaultCall: __defaultImplStub!._callActive = newValue)
        }
        
    }
    
    
    
    
    
     override var _etag: String? {
        get {
            return cuckoo_manager.getter("_etag",
                superclassCall:
                    
                    super._etag
                    ,
                defaultCall: __defaultImplStub!._etag)
        }
        
        set {
            cuckoo_manager.setter("_etag",
                value: newValue,
                superclassCall:
                    
                    super._etag = newValue
                    ,
                defaultCall: __defaultImplStub!._etag = newValue)
        }
        
    }
    
    
    
    
    
     override var canStart: Bool {
        get {
            return cuckoo_manager.getter("canStart",
                superclassCall:
                    
                    super.canStart
                    ,
                defaultCall: __defaultImplStub!.canStart)
        }
        
    }
    
    
    
    
    
     override var timeoutInSeconds: Double {
        get {
            return cuckoo_manager.getter("timeoutInSeconds",
                superclassCall:
                    
                    super.timeoutInSeconds
                    ,
                defaultCall: __defaultImplStub!.timeoutInSeconds)
        }
        
    }
    
    

    

    
    
    
    
     override func initialize() async {
        
    return await cuckoo_manager.call(
    """
    initialize() async
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.initialize()
                ,
            defaultCall: await __defaultImplStub!.initialize())
        
    }
    
    
    
    
    
     override func ensureCacheExpired()  {
        
    return cuckoo_manager.call(
    """
    ensureCacheExpired()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.ensureCacheExpired()
                ,
            defaultCall: __defaultImplStub!.ensureCacheExpired())
        
    }
    
    
    
    
    
     override func ensureCacheNotExpired()  {
        
    return cuckoo_manager.call(
    """
    ensureCacheNotExpired()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.ensureCacheNotExpired()
                ,
            defaultCall: __defaultImplStub!.ensureCacheNotExpired())
        
    }
    
    
    
    
    
     override func poll() async {
        
    return await cuckoo_manager.call(
    """
    poll() async
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.poll()
                ,
            defaultCall: await __defaultImplStub!.poll())
        
    }
    
    
    
    
    
     override func context_change(new_header: String) async {
        
    return await cuckoo_manager.call(
    """
    context_change(new_header: String) async
    """,
            parameters: (new_header),
            escapingParameters: (new_header),
            superclassCall:
                
                await super.context_change(new_header: new_header)
                ,
            defaultCall: await __defaultImplStub!.context_change(new_header: new_header))
        
    }
    
    
    
    
    
     override func close()  {
        
    return cuckoo_manager.call(
    """
    close()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.close()
                ,
            defaultCall: __defaultImplStub!.close())
        
    }
    
    

     struct __StubbingProxy_UseBasedEdge: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var _timeoutInSeconds: Cuckoo.ClassToBeStubbedProperty<MockUseBasedEdge, Double> {
            return .init(manager: cuckoo_manager, name: "_timeoutInSeconds")
        }
        
        
        
        
        var _initialized: Cuckoo.ClassToBeStubbedProperty<MockUseBasedEdge, Bool> {
            return .init(manager: cuckoo_manager, name: "_initialized")
        }
        
        
        
        
        var _stopped: Cuckoo.ClassToBeStubbedProperty<MockUseBasedEdge, Bool> {
            return .init(manager: cuckoo_manager, name: "_stopped")
        }
        
        
        
        
        var _header: Cuckoo.ClassToBeStubbedOptionalProperty<MockUseBasedEdge, String> {
            return .init(manager: cuckoo_manager, name: "_header")
        }
        
        
        
        
        var _cacheTimeout: Cuckoo.ClassToBeStubbedProperty<MockUseBasedEdge, Date> {
            return .init(manager: cuckoo_manager, name: "_cacheTimeout")
        }
        
        
        
        
        var _contextSha: Cuckoo.ClassToBeStubbedProperty<MockUseBasedEdge, String> {
            return .init(manager: cuckoo_manager, name: "_contextSha")
        }
        
        
        
        
        var _callActive: Cuckoo.ClassToBeStubbedProperty<MockUseBasedEdge, Bool> {
            return .init(manager: cuckoo_manager, name: "_callActive")
        }
        
        
        
        
        var _etag: Cuckoo.ClassToBeStubbedOptionalProperty<MockUseBasedEdge, String> {
            return .init(manager: cuckoo_manager, name: "_etag")
        }
        
        
        
        
        var canStart: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockUseBasedEdge, Bool> {
            return .init(manager: cuckoo_manager, name: "canStart")
        }
        
        
        
        
        var timeoutInSeconds: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockUseBasedEdge, Double> {
            return .init(manager: cuckoo_manager, name: "timeoutInSeconds")
        }
        
        
        
        
        
        func initialize() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockUseBasedEdge.self, method:
    """
    initialize() async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func ensureCacheExpired() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockUseBasedEdge.self, method:
    """
    ensureCacheExpired()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func ensureCacheNotExpired() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockUseBasedEdge.self, method:
    """
    ensureCacheNotExpired()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func poll() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockUseBasedEdge.self, method:
    """
    poll() async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func context_change<M1: Cuckoo.Matchable>(new_header: M1) -> Cuckoo.ClassStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: new_header) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockUseBasedEdge.self, method:
    """
    context_change(new_header: String) async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func close() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockUseBasedEdge.self, method:
    """
    close()
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_UseBasedEdge: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var _timeoutInSeconds: Cuckoo.VerifyProperty<Double> {
            return .init(manager: cuckoo_manager, name: "_timeoutInSeconds", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _initialized: Cuckoo.VerifyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "_initialized", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _stopped: Cuckoo.VerifyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "_stopped", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _header: Cuckoo.VerifyOptionalProperty<String> {
            return .init(manager: cuckoo_manager, name: "_header", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _cacheTimeout: Cuckoo.VerifyProperty<Date> {
            return .init(manager: cuckoo_manager, name: "_cacheTimeout", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _contextSha: Cuckoo.VerifyProperty<String> {
            return .init(manager: cuckoo_manager, name: "_contextSha", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _callActive: Cuckoo.VerifyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "_callActive", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var _etag: Cuckoo.VerifyOptionalProperty<String> {
            return .init(manager: cuckoo_manager, name: "_etag", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var canStart: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "canStart", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var timeoutInSeconds: Cuckoo.VerifyReadOnlyProperty<Double> {
            return .init(manager: cuckoo_manager, name: "timeoutInSeconds", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
        func ensureCacheExpired() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    ensureCacheExpired()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func ensureCacheNotExpired() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    ensureCacheNotExpired()
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


 class UseBasedEdgeStub: UseBasedEdge {
    
    
    
    
     override var _timeoutInSeconds: Double {
        get {
            return DefaultValueRegistry.defaultValue(for: (Double).self)
        }
        
        set { }
        
    }
    
    
    
    
    
     override var _initialized: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    
    
    
    
    
     override var _stopped: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    
    
    
    
    
     override var _header: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    
    
    
    
     override var _cacheTimeout: Date {
        get {
            return DefaultValueRegistry.defaultValue(for: (Date).self)
        }
        
        set { }
        
    }
    
    
    
    
    
     override var _contextSha: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
        set { }
        
    }
    
    
    
    
    
     override var _callActive: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    
    
    
    
    
     override var _etag: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    
    
    
    
     override var canStart: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
    
    
    
     override var timeoutInSeconds: Double {
        get {
            return DefaultValueRegistry.defaultValue(for: (Double).self)
        }
        
    }
    
    

    

    
    
    
    
     override func initialize() async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func ensureCacheExpired()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func ensureCacheNotExpired()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func poll() async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func context_change(new_header: String) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func close()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}




