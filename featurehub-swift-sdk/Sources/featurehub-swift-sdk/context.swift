
import Foundation

enum ContextKeys {
    case userKey, session, country, platform, device, version
}

public class ClientContext {
    let repo: FeatureRepository
    var attributes: [String: [String]] = [:]

    public init(_ repo: FeatureRepository) {
        self.repo = repo
    }

    func user(_ value: String) -> ClientContext {
        attributes["userkey"] = [value]
        return self
    }

    func session(_ value: String) -> ClientContext {
        attributes["session"] = [value]
        return self
    }

    func country(_ value: StrategyAttributeCountryName)  -> ClientContext{
        attributes["country"] = [value.rawValue]
        return self
    }

    func device(_ value: StrategyAttributeDeviceName) -> ClientContext {
        attributes["device"] = [value.rawValue]
        return self
    }

    func platform(_ value: StrategyAttributePlatformName) -> ClientContext {
        attributes["platform"] = [value.rawValue]
        return self
    }

    func version(_ value: String) -> ClientContext {
        attributes["version"] = [value]
        return self
    }

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

    func number(_ key: String) -> Float? {
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

    func build() async -> ClientContext {
        self
    }

    /// used: interval function for use by features to indicate they are  being evaluated
    /// so theh cache can expire
    func used() async {}
}
