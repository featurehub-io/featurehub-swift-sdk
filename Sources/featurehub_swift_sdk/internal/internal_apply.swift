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
        return Double(val as! Int)
      } else if (val is Float) {
        return Double(val as! Float)
      } else if (val is Double) {
        return val as! Double
      } else if (val is String) {
        return Double(val as! String)
      }

      return nil
    }
  }

  func toString(_ expectedType: FeatureValueType) -> String? {
    if (nil == val) {
      return nil
    }

    switch expectedType {

    case .boolean:
      if val is Bool {
        return (val as! Bool) ? "true" : "false"
      } else if val is String {
        return ((val as? String)?.lowercased() == "true") ? "true" : "false"
      }

      return "false"
    case .string, .json:
      if (val is String) {
        return val as? String
      }
      return String(describing: val)
    case .number:
      var d: Double?
      if (val is Int) {
        d = Double(val as! Int)
      } else if (val is Float) {
        d =  Double(val as! Float)
      } else if (val is Double) {
        d = val as? Double
      } else if (val is String) {
        d = Double(val as! String)
      }

      if let dbl = d {
        return String(dbl)
      }

      return nil
    }
  }
}
