import Foundation


public protocol ClientContext {
  @discardableResult
  func user(_ value: String) -> ClientContext
  @discardableResult
  func session(_ value: String) -> ClientContext
  @discardableResult
  func country(_ value: StrategyAttributeCountryName) -> ClientContext
  @discardableResult
  func device(_ value: StrategyAttributeDeviceName) -> ClientContext
  @discardableResult
  func platform(_ value: StrategyAttributePlatformName) -> ClientContext
  @discardableResult
  func version(_ value: String) -> ClientContext
  @discardableResult
  func attribute(_ key: String, _ value: String) -> ClientContext
  @discardableResult
  func attributes(_ key: String, _ value: [String]) -> ClientContext
  @discardableResult
  func clear() -> ClientContext

  func attr(_ key: String) -> [String]?

  func feature(_ key: String) -> RepositoryFeatureState
  func enabled(_ key: String) -> Bool
  func hasValue(_ key: String) -> Bool
  func number(_ key: String) -> Double?
  func string(_ key: String) -> String?
  func json(_ key: String) -> String?
  func flag(_ key: String) -> Bool?
  func exists(_ key: String) -> Bool?
  var readiness: Readiness { get }

  @discardableResult
  func build() async -> ClientContext
}

public class BaseClientContext : ClientContext {
  let repo: FeatureRepository
  internal var attributes: [String: [String]] = [:]

  public init(_ repo: FeatureRepository) {
    self.repo = repo
  }

  @discardableResult
  public func user(_ value: String) -> ClientContext {
    attributes[ContextKeys.userKey.rawValue] = [value]
    return self
  }

  @discardableResult
  public func session(_ value: String) -> ClientContext {
    attributes[ContextKeys.session.rawValue] = [value]
    return self
  }

  @discardableResult
  public func country(_ value: StrategyAttributeCountryName) -> ClientContext {
    attributes[ContextKeys.country.rawValue] = [value.rawValue]
    return self
  }

  @discardableResult
  public func device(_ value: StrategyAttributeDeviceName) -> ClientContext {
    attributes[ContextKeys.device.rawValue] = [value.rawValue]
    return self
  }

  @discardableResult
  public func platform(_ value: StrategyAttributePlatformName) -> ClientContext {
    attributes[ContextKeys.platform.rawValue] = [value.rawValue]
    return self
  }

  @discardableResult
  public func version(_ value: String) -> ClientContext {
    attributes[ContextKeys.version.rawValue] = [value]
    return self
  }

  /// lets you easily set a single value for an attribute
  @discardableResult
  public func attribute(_ key: String, _ value: String) -> ClientContext {
    attributes[key] = [value]
    return self
  }

  /// lets you set an array of values for an attribute
  @discardableResult
  public func attributes(_ key: String, _ value: [String]) -> ClientContext {
    attributes[key] = value
    return self
  }

  @discardableResult
  public func clear() -> ClientContext {
    attributes.removeAll()
    return self
  }

  public func attr(_ key: String) -> [String]? {
    attributes[key]
  }

  func defaultPercentageKey() -> String? {
    let value = attributes["session"] ?? attributes["userkey"]

    if value == nil || value!.isEmpty {
      return nil
    }

    return value![0]
  }

  public func feature(_ key: String) -> RepositoryFeatureState {
    repo.feature(key)
  }

  public func enabled(_ key: String) -> Bool {
    feature(key).enabled
  }

  public func hasValue(_ key: String) -> Bool {
    feature(key).hasValue
  }

  public func number(_ key: String) -> Double? {
    feature(key).number
  }

  public func string(_ key: String) -> String? {
    feature(key).string
  }

  public func json(_ key: String) -> String? {
    feature(key).json
  }

  public func flag(_ key: String) -> Bool? {
    feature(key).flag
  }

  public func exists(_ key: String) -> Bool? {
    feature(key).exists
  }

  public var readiness: Readiness { get { repo.readiness }}

  @discardableResult
  public func build() async -> ClientContext {
    self
  }

  /// used: interval function for use by features to indicate they are  being evaluated
  /// so theh cache can expire. Also to be used for analytics.
  func used(_ key: String, _ id: UUID?, _ val: Any?, _ valueType: FeatureValueType) async {
  }
}
