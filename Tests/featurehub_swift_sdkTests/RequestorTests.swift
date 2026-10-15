//
// The request the default requestor sends, and how it hands back responses the generated client
// treats as errors.
//

import Foundation
@testable import featurehub_swift_sdk
import Quick
import Nimble

final class RequestorTests: QuickSpec {
  override func spec() {
    describe("the request") {
      afterEach {
        OpenAPIClientAPI.customHeaders.removeAll()
      }

      it("is sent to the config's server, whether or not its url ends in a slash") {
        for url in ["http://edge.example.com", "http://edge.example.com/"] {
          let builder = DefaultFeatureRequestor(url).requestBuilder(apiKeys: ["k1"], contextSha: "abc", etag: nil, header: nil)

          expect(builder.URLString).to(beginWith("http://edge.example.com/features/?"))
          expect(builder.URLString).to(contain("apiKey=k1"))
          expect(builder.URLString).to(contain("contextSha=abc"))
          expect(builder.method) == "GET"
        }
      }

      it("sends its own etag and context, even if the global headers have others") {
        OpenAPIClientAPI.customHeaders["x-featurehub"] = "userkey=someone-else"
        OpenAPIClientAPI.customHeaders["if-none-match"] = "someone-elses-etag"

        let builder = DefaultFeatureRequestor("http://edge.example.com")
          .requestBuilder(apiKeys: ["k1"], contextSha: "abc", etag: "1234", header: "userkey=me")
        let headers = (builder as! URLSessionRequestBuilder<[FeatureEnvironmentCollection]>).buildHeaders()

        expect(headers["x-featurehub"]) == "userkey=me"
        expect(headers["if-none-match"]) == "1234"
      }

      it("sends no etag or context when there are none") {
        let builder = DefaultFeatureRequestor("http://edge.example.com")
          .requestBuilder(apiKeys: ["k1"], contextSha: "0", etag: nil, header: nil)
        let headers = (builder as! URLSessionRequestBuilder<[FeatureEnvironmentCollection]>).buildHeaders()

        expect(headers["x-featurehub"]).to(beNil())
        expect(headers["if-none-match"]).to(beNil())
      }
    }

    describe("a status the generated client throws for") {
      func httpError(_ statusCode: Int, _ headers: [String: String] = [:]) -> Error {
        let response = HTTPURLResponse(url: URL(string: "http://edge.example.com/features/")!, statusCode: statusCode,
          httpVersion: nil, headerFields: headers)!
        return ErrorResponse.error(statusCode, nil, response, DecodableRequestBuilderError.unsuccessfulHTTPStatusCode)
      }

      it("is handed back for a 404 so the edge can stop") {
        let response = DefaultFeatureRequestor.response(from: httpError(404))
        expect(response?.statusCode) == 404
        expect(response?.body).to(beEmpty())
      }

      it("is handed back for a 400") {
        expect(DefaultFeatureRequestor.response(from: httpError(400))?.statusCode) == 400
      }

      it("is handed back for a 304 with its headers") {
        let response = DefaultFeatureRequestor.response(from: httpError(304, ["etag": "1234"]))
        expect(response?.statusCode) == 304
        expect(response?.header.first { $0.key.lowercased() == "etag" }?.value) == "1234"
      }

      it("is nothing when there was no response at all") {
        expect(DefaultFeatureRequestor.response(from: ErrorResponse.error(-1, nil, nil, URLError(.notConnectedToInternet)))).to(beNil())
        expect(DefaultFeatureRequestor.response(from: URLError(.timedOut))).to(beNil())
      }
    }

    describe("the edge given a real response") {
      it("picks up the etag and cache-control whatever case their names are in") {
        let requestor = ScriptedRequestor()
        let http = HTTPURLResponse(url: URL(string: "http://localhost/features/")!, statusCode: 200, httpVersion: "HTTP/1.1",
          headerFields: ["etag": "1234", "cache-control": "max-age=45"])!
        requestor.respond = { _ in Response(response: http, body: [FeatureEnvironmentCollection(id: UUID())], bodyData: nil) }
        let edge = UseBasedEdge(Repository(), try! EdgeFeatureHubConfig("http://localhost", ["123/abc"]), 30, requestor: requestor)

        await edge.poll()
        expect(edge.etag) == "1234"
        expect(edge.timeoutInSeconds) == 45
      }
    }

    describe("the edge given a failed request") {
      it("stops and tells the repository on a 404") {
        let repo = Repository()
        let requestor = ScriptedRequestor()
        requestor.respond = { _ in DefaultFeatureRequestor.response(from: httpError(404)) }
        let edge = UseBasedEdge(repo, try! EdgeFeatureHubConfig("http://localhost", ["123/abc"]), 30, requestor: requestor)

        await edge.poll()
        expect(repo.readiness) == .failed

        edge.ensureCacheExpired()
        await edge.poll()
        expect(requestor.calls.count) == 1
      }

      func httpError(_ statusCode: Int) -> Error {
        let response = HTTPURLResponse(url: URL(string: "http://localhost/features/")!, statusCode: statusCode,
          httpVersion: nil, headerFields: [:])!
        return ErrorResponse.error(statusCode, nil, response, DecodableRequestBuilderError.unsuccessfulHTTPStatusCode)
      }
    }
  }
}

// a requestor that records what it is asked for, answers with `respond` and, while `hold` is set,
// doesn't answer until `release()` is called
final class ScriptedRequestor: FeatureRequestor {
  struct Call {
    let contextSha: String?
    let etag: String?
    let header: String?
  }

  private let lock = NSLock()
  private var _calls: [Call] = []
  private var _hold = false
  private var _waiting: [CheckedContinuation<Void, Never>] = []
  private var _respond: (Call) -> Response<[FeatureEnvironmentCollection]>? = { _ in nil }

  var calls: [Call] { lock.synchronized { _calls } }
  var waiting: Int { lock.synchronized { _waiting.count } }

  var hold: Bool {
    get { lock.synchronized { _hold } }
    set { lock.synchronized { _hold = newValue } }
  }

  var respond: (Call) -> Response<[FeatureEnvironmentCollection]>? {
    get { lock.synchronized { _respond } }
    set { lock.synchronized { _respond = newValue } }
  }

  func release() {
    let waiting: [CheckedContinuation<Void, Never>] = lock.synchronized {
      let w = _waiting
      _waiting = []
      return w
    }

    waiting.forEach { $0.resume() }
  }

  func getFeatureStates(apiKeys: [String], contextSha: String?, etag: String?, header: String?) async -> Response<[FeatureEnvironmentCollection]>? {
    let call = Call(contextSha: contextSha, etag: etag, header: header)
    let hold: Bool = lock.synchronized {
      _calls.append(call)
      return _hold
    }

    if hold {
      await withCheckedContinuation { (c: CheckedContinuation<Void, Never>) in
        lock.synchronized { _waiting.append(c) }
      }
    }

    return respond(call)
  }

  static func features(_ keys: String..., etag: String? = nil) -> Response<[FeatureEnvironmentCollection]> {
    Response(statusCode: 200, header: etag.map { ["etag": $0] } ?? [:],
      body: [FeatureEnvironmentCollection(id: UUID(), features: keys.map {
        FeatureState(id: UUID(), key: $0, l: false, version: 1, type: .boolean, value: true)
      })], bodyData: nil)
  }
}

// waits (briefly) for something another task is doing
func eventually(_ condition: () -> Bool) async {
  for _ in 0..<300 {
    if condition() {
      return
    }

    try? await Task.sleep(nanoseconds: 10_000_000)
  }
}
