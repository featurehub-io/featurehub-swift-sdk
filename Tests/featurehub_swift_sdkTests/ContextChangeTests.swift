//
// How a context change is handed from the context to the edge while other requests are going on.
//

import Foundation
@testable import featurehub_swift_sdk
import Quick
import Nimble

// an edge whose context changes take a while, so a build can still be waiting on one
private final class SlowEdge: EdgeService {
  private let lock = NSLock()
  private var _started = 0
  private var _finished = 0

  var started: Int { lock.synchronized { _started } }
  var finished: Int { lock.synchronized { _finished } }

  func poll() async {
  }

  func context_change(_ new_header: String) async {
    lock.synchronized { _started += 1 }
    try? await Task.sleep(nanoseconds: 200_000_000)
    lock.synchronized { _finished += 1 }
  }

  func close() {
  }
}

final class ContextChangeTests: QuickSpec {
  override func spec() {
    var repo: Repository!
    var requestor: ScriptedRequestor!
    var edge: UseBasedEdge!

    beforeEach {
      repo = Repository()
      requestor = ScriptedRequestor()
      edge = UseBasedEdge(repo, try! EdgeFeatureHubConfig("http://localhost", ["123/abc"]), 30, requestor: requestor)
    }

    describe("building a context") {
      it("waits for an earlier build of the same context to reach the edge") {
        let slowEdge = SlowEdge()
        let ctx = ServerEvalFeatureContext(Repository(), slowEdge)
        ctx.user("a")

        let first = Task { await ctx.build() } // like the build start() kicks off
        await eventually { slowEdge.started == 1 }

        await ctx.build()
        expect(slowEdge.started) == 1
        expect(slowEdge.finished) == 1

        await first.value
      }

      it("doesn't report ready until the new context's features have arrived") {
        let ctx = ServerEvalFeatureContext(repo, edge)
        requestor.respond = { call in
          call.header == "userkey=b" ? ScriptedRequestor.features("for-b") : ScriptedRequestor.features("for-old-context")
        }

        // a poll for the old context is in flight when the context changes
        requestor.hold = true
        let inflight = Task { await edge.poll() }
        await eventually { requestor.waiting == 1 }

        requestor.hold = false
        ctx.user("b")
        await ctx.build()
        expect(repo.readiness) == .ready
        expect(repo.feature("for-b").exists) == true

        // the old context's answer arrives late and is ignored
        requestor.release()
        await inflight.value
        expect(repo.feature("for-old-context").exists) == false
      }
    }

    describe("a context change queued with the edge") {
      it("means a response already in flight for the old context is ignored") {
        requestor.respond = { _ in ScriptedRequestor.features("for-old-context") }
        requestor.hold = true
        let inflight = Task { await edge.poll() }
        await eventually { requestor.waiting == 1 }

        edge.contextChangeQueued()
        requestor.release()
        await inflight.value

        expect(repo.readiness) == .notReady
        expect(repo.feature("for-old-context").exists) == false
      }

      it("holds back other polls until it arrives, and then makes the request itself") {
        requestor.respond = { _ in ScriptedRequestor.features("f") }
        edge.contextChangeQueued()

        await edge.poll() // e.g. from a feature being used
        expect(requestor.calls.count) == 0

        await edge.context_change("userkey=b")
        expect(requestor.calls.map { $0.header }) == ["userkey=b"]
        expect(repo.readiness) == .ready
      }

      it("only makes the request for the newest of several changes") {
        requestor.respond = { _ in ScriptedRequestor.features("f") }
        edge.contextChangeQueued()
        edge.contextChangeQueued()

        await edge.context_change("userkey=b")
        await edge.context_change("userkey=c")
        expect(requestor.calls.map { $0.header }) == ["userkey=c"]
      }

      it("still makes a request when the header is the one the edge already has") {
        requestor.respond = { _ in ScriptedRequestor.features("f", etag: "etag-for-a") }
        await edge.context_change("userkey=a")

        // a poll for the same context is in flight when the change is queued, so its answer is discarded
        edge.ensureCacheExpired()
        requestor.hold = true
        let inflight = Task { await edge.poll() }
        await eventually { requestor.waiting == 1 }

        edge.contextChangeQueued()
        repo.notReady()
        requestor.release()
        await inflight.value
        expect(repo.readiness) == .notReady

        requestor.hold = false
        await edge.context_change("userkey=a")
        expect(requestor.calls.count) == 3
        // without the etag, so we get the features back rather than a 304
        expect(requestor.calls.last?.etag).to(beNil())
        expect(repo.readiness) == .ready
      }
    }

    describe("a server evaluated context") {
      it("no longer has the features the previous context had that the new one doesn't") {
        let ctx = ServerEvalFeatureContext(repo, edge)
        requestor.respond = { call in
          call.header == "userkey=a" ? ScriptedRequestor.features("x", "y") : ScriptedRequestor.features("y")
        }

        ctx.user("a")
        await ctx.build()
        expect(ctx.feature("x").enabled) == true

        ctx.user("b")
        await ctx.build()
        expect(ctx.feature("x").exists) == false
        expect(ctx.feature("x").enabled) == false
        expect(ctx.feature("y").enabled) == true
      }
    }

    describe("a context change") {
      it("isn't held up by a poll that starts while it is being made") {
        requestor.respond = { _ in ScriptedRequestor.features("f") }
        requestor.hold = true
        let change = Task { await edge.context_change("userkey=b") }
        await eventually { requestor.waiting == 1 }

        await edge.poll() // the request is already the context change's, so this does nothing
        expect(requestor.calls.count) == 1

        requestor.release()
        await change.value
        expect(repo.readiness) == .ready
      }

      it("doesn't send the old context's etag") {
        requestor.respond = { _ in ScriptedRequestor.features("f", etag: "etag-for-a") }
        await edge.context_change("userkey=a")
        expect(edge.etag) == "etag-for-a"

        await edge.context_change("userkey=b")
        expect(requestor.calls.last?.header) == "userkey=b"
        expect(requestor.calls.last?.etag).to(beNil())
      }

      it("still sends the etag when polling the same context again") {
        requestor.respond = { _ in ScriptedRequestor.features("f", etag: "etag-for-a") }
        await edge.context_change("userkey=a")

        edge.ensureCacheExpired()
        await edge.poll()
        expect(requestor.calls.last?.etag) == "etag-for-a"
      }
    }
  }
}
