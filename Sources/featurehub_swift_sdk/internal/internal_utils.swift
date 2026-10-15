import Foundation
import Logging

var logger = Logger(label: "io.featurehub")

extension NSLocking {
  /// runs the block while holding the lock. It is synchronous, so the lock is never held across an await.
  func synchronized<T>(_ block: () throws -> T) rethrows -> T {
    lock()
    defer { unlock() }
    return try block()
  }
}
