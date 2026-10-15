//
// The application sets context attributes and builds contexts from whatever threads it likes,
// often while the build started by config.start() is still running in the background.
//

import Foundation
@testable import featurehub_swift_sdk
import Quick
import Nimble

// records the context changes it is sent, the Cuckoo mocks aren't safe to call from several threads
private class RecordingEdge: EdgeService {
  private let lock = NSLock()
  private var _headers: [String] = []

  var headers: [String] {
    lock.lock()
    defer { lock.unlock() }
    return _headers
  }

  func poll() async {
  }

  func context_change(_ new_header: String) async {
    lock.lock()
    defer { lock.unlock() }
    _headers.append(new_header)
  }

  func close() {
  }
}

final class ContextConcurrencyTests: QuickSpec {
  override func spec() {
    describe("a server evaluated context used from several threads at once") {
      it("survives attributes being set while it is being built, and sends the latest context last") {
        let edge = RecordingEdge()
        let ctx = ServerEvalFeatureContext(Repository(), edge)

        await withTaskGroup(of: Void.self) { group in
          for worker in 0..<8 {
            group.addTask {
              for round in 0..<200 {
                if worker % 2 == 0 { // pretend to be the application changing the context
                  ctx.user("user-\(worker)-\(round)").attribute("round", "\(round)")
                  if round % 50 == 0 {
                    ctx.clear()
                  }
                } else { // pretend to be the builds started by the application and start()
                  await ctx.build()
                }
              }
            }
          }
        }

        ctx.clear().user("final")
        await ctx.build()

        expect(edge.headers.last).to(equal("userkey=final"))
      }
    }

    describe("a config used from several threads at once") {
      it("only ever makes one repository and one server context") {
        let config = try! EdgeFeatureHubConfig("http://localhost", ["123/abc"])
        let contexts = NSMutableArray()
        let repositories = NSMutableArray()
        let lock = NSLock()

        DispatchQueue.concurrentPerform(iterations: 16) { _ in
          let ctx = config.newContext()
          let repo = config.repository
          lock.lock()
          contexts.add(ctx)
          repositories.add(repo)
          lock.unlock()
        }

        let first = contexts[0] as AnyObject
        expect(contexts.allSatisfy { ($0 as AnyObject) === first }).to(beTrue())
        let firstRepo = repositories[0] as AnyObject
        expect(repositories.allSatisfy { ($0 as AnyObject) === firstRepo }).to(beTrue())
      }
    }
  }
}
