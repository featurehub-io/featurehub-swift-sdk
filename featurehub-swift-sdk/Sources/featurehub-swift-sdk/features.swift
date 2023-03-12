import Foundation

public protocol RepositoryFeatureState {
  /// does the feature actually exist - you can ask for any feature, and will always get
  /// an object but it will return false if the object is not backed by a real feature. This
  /// allows you to grab features before they even receive state from the server.
  /// - Returns: true if feature exists
  var exists: Bool { get }
  /// is this feature locked (not changable from the server). Locked features cannot have
  /// overrides
  /// - Returns: true if feature is locked
  var locked: Bool { get }
  /// the unique id of the feature. Its key can change but its id wont change
  ///
  /// - Returns: UUID of the feature or nil if it doesn't exist
  var id: UUID? { get }
  /// - the actual type of the feature
  ///
  /// - Returns: string, json, number, json, nil
  var featureType: FeatureValueType? { get }
  /// - the version of the feature value - as it changes over time.
  ///
  /// - Returns: The version number or -1 for a non-existent feature
  var version: Int64 { get }
  /// The string of the feature
  ///
  /// - Returns: the string of the feature or nil if it doesn't exist
  var string: String? { get }
  /// The float of the feature
  ///
  /// - Returns: the float of the feature or nil if it doesn't exist
  var number: Double? { get }
  /// The json string of the feature
  ///
  /// - Returns: the string of the feature or nil if it doesn't exist
  var json: String? { get }
  /// The bool value of the feature if its a boolean flag, or nil if the feature does not exist. Use
  /// enabled for a more reliable
  ///
  /// - Returns: true/false/nil
  var flag: Bool? { get }
  var enabled: Bool { get }
  var hasValue: Bool { get }
}


