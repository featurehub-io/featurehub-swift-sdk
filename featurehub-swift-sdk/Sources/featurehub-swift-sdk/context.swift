import Foundation


public class ClientContext {
  let repo: FeatureRepository
  var attributes: [String: [String]] = [:]

  public init(_ repo: FeatureRepository) {
    self.repo = repo
  }

  @discardableResult
  func user(_ value: String) -> ClientContext {
    attributes[ContextKeys.userKey.rawValue] = [value]
    return self
  }

  @discardableResult
  func session(_ value: String) -> ClientContext {
    attributes[ContextKeys.session.rawValue] = [value]
    return self
  }

  @discardableResult
  func country(_ value: StrategyAttributeCountryName) -> ClientContext {
    attributes[ContextKeys.country.rawValue] = [value.rawValue]
    return self
  }

  @discardableResult
  func device(_ value: StrategyAttributeDeviceName) -> ClientContext {
    attributes[ContextKeys.device.rawValue] = [value.rawValue]
    return self
  }

  @discardableResult
  func platform(_ value: StrategyAttributePlatformName) -> ClientContext {
    attributes[ContextKeys.platform.rawValue] = [value.rawValue]
    return self
  }

  @discardableResult
  func version(_ value: String) -> ClientContext {
    attributes[ContextKeys.version.rawValue] = [value]
    return self
  }

  @discardableResult
  func clear() -> ClientContext {
    attributes.removeAll()
    return self
  }

  subscript(_ key: String) -> [String]? {
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

  func feature(_ key: String) -> RepositoryFeatureState? {
    repo.feature(key)
  }

  func enabled(_ key: String) -> Bool {
    feature(key)?.enabled ?? false
  }

  func hasValue(_ key: String) -> Bool {
    feature(key)?.hasValue ?? false
  }

  func number(_ key: String) -> Double? {
    feature(key)?.number
  }

  func string(_ key: String) -> String? {
    feature(key)?.string
  }

  func json(_ key: String) -> String? {
    feature(key)?.json
  }

  func flag(_ key: String) -> Bool? {
    feature(key)?.flag
  }

  func exists(_ key: String) -> Bool? {
    feature(key)?.exists
  }

  @discardableResult
  func build() async -> ClientContext {
    self
  }

  /// used: interval function for use by features to indicate they are  being evaluated
  /// so theh cache can expire. Also to be used for analytics.
  func used(_ key: String, _ id: UUID?, _ val: Any?) async {
  }
}
