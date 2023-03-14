import Foundation

public protocol EdgeService {
  func initialize() async -> Void
  func poll() async -> Void
  func context_change(new_header: String) async -> Void
  func close() -> Void
}


public enum Readiness {
  case ready, notReady, stalled, failed
}

public protocol FeatureRepository {
  func feature(_ key: String) -> RepositoryFeatureState
  var readiness: Readiness { get }
  func registerFeatureValueInterceptor(allowOverrideLock: Bool, interceptor: FeatureValueInterceptor)
}



