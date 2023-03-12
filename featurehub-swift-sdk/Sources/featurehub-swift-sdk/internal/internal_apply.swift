import Foundation

public class AppliedValue {
  let matched: Bool
  let value: Any?

  public init(_ matched: Bool, _ value: Any?) {
    self.matched = matched
    self.value = value
  }
}

public class InterceptorValue {
  let val: Any?

  init(_ val: Any?) {
    self.val = val
  }

  func cast(_ expectedType: FeatureValueType) -> Any? {
    if (nil == val) {
      return nil
    }

    switch expectedType {

    case .boolean:
      if val is Bool {
        return val
      } else if val is String {
        return (val as? String)?.lowercased() == "true"
      }

      return false
    case .string, .json:
      if (val is String) {
        return val
      }
      return String(describing: val)
    case .number:
      if (val is Int) {
        return Float(val as! Int)
      } else if (val is Float) {
        return val as! Float
      }

      return nil
    }
  }
}
