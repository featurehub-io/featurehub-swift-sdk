import Foundation


public class ClientContext {
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

  /// allows you to access the attribute values as a subscript
  public subscript(_ key: String) -> [String]? {
    get {
      attributes[key]
    }
    set(newValue) {
      attributes[key] = newValue
    }
  }

  func defaultPercentageKey() -> String? {
    let value = attributes["session"] ?? attributes["userkey"]

    if value == nil || value!.isEmpty {
      return nil
    }

    return value![0]
  }

  public func feature(_ key: String) -> RepositoryFeatureState? {
    repo.feature(key)
  }

  public func enabled(_ key: String) -> Bool {
    feature(key)?.enabled ?? false
  }

  public func hasValue(_ key: String) -> Bool {
    feature(key)?.hasValue ?? false
  }

  public func number(_ key: String) -> Double? {
    feature(key)?.number
  }

  public func string(_ key: String) -> String? {
    feature(key)?.string
  }

  public func json(_ key: String) -> String? {
    feature(key)?.json
  }

  public func flag(_ key: String) -> Bool? {
    feature(key)?.flag
  }

  public func exists(_ key: String) -> Bool? {
    feature(key)?.exists
  }

  public var readiness: Readiness { get { repo.readiness }}

  @discardableResult
  public func build() async -> ClientContext {
    self
  }

  /// used: interval function for use by features to indicate they are  being evaluated
  /// so theh cache can expire. Also to be used for analytics.
  func used(_ key: String, _ id: UUID?, _ val: Any?) async {
  }
}
