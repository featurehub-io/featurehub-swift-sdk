//
// Created by richard on 14/03/23.
//

import Foundation
@testable import featurehub_swift_sdk
import Quick
import Nimble
import Cuckoo
import Logging

func equal(to value: SSEResultState?) -> ParameterMatcher<SSEResultState?> {
  return ParameterMatcher {
    tested in value == tested
  }
}
//
//func equal(to value: [FeatureState]) -> ParameterMatcher<[FeatureState]> {
//  return ParameterMatcher { tested in value == tested  }
//}

final class UseBasedEdgeTests : QuickSpec {
  override func spec() {
    var edge: UseBasedEdge!
    var requestor: MockFeatureRequestor!
    var repository: MockInternalFeatureRepository!
    var config: MockFeatureHubConfig!
    var etag: String? = nil
    var contextSha = "0"

    beforeEach {
      requestor = MockFeatureRequestor()
      repository = MockInternalFeatureRepository()
      config = MockFeatureHubConfig()

      stub(config) { cfg in
          cfg.apiKeys.get.thenReturn(["x"])
          cfg.baseUrl.get.thenReturn("http://localhost:8085")
      }

      edge = UseBasedEdge(repository, config, 30, requestor: requestor)
    }

    afterEach {
      etag = nil
      contextSha = "0"
//      verifyNoMoreInteractions(requestor)
//      verifyNoMoreInteractions(repository)
//      verifyNoMoreInteractions(config)
    }

    func stubResp(_ resp: Response<[FeatureEnvironmentCollection]>) {
      stub(requestor) { r in
        r.getFeatureStates(apiKeys: ["x"], contextSha: contextSha, etag: etag).thenReturn(resp)
      }
    }

    func emptyDataCall(code: Int, _ headers: [String: String]? = nil, doPoll: Bool = true) async {
      var h: [String: String] = ["Content-Type": "application/json"]

      if let hdrs = headers {
        hdrs.forEach( { k,v in h[k] = v })
      }

      let resp = Response<[FeatureEnvironmentCollection]>(statusCode: code,
        header: h,
        body: [FeatureEnvironmentCollection(id: UUID())], bodyData: nil)

      stubResp(resp)

      stub(repository) { r in
        r.notify(status: any()).thenDoNothing()
        r.empty().thenDoNothing()
      }

      if doPoll {
        await edge.poll()
      }
    }


    describe("the api is called") {
      afterEach {
        verify(config).apiKeys.get()
        verify(requestor).getFeatureStates(apiKeys: ["x"], contextSha: contextSha, etag: etag)
      }


      it("should poll on start") {
        let resp = Response<[FeatureEnvironmentCollection]>(statusCode: 200,
          header: ["Content-Type": "application/json"],
          body: [FeatureEnvironmentCollection(id: UUID())], bodyData: nil)

        stubResp(resp)

        stub(repository) { r in
          r.empty().thenDoNothing()
        }

        await edge.poll()

        verify(repository).empty()
      }

      it("should pass features back to the repository on a 236") {
        let f1 = FeatureState(id: UUID(), key: "bool", l: false, version: 1, type: .boolean, value: true)
        let f2 = FeatureState(id: UUID(), key: "str", l: false, version: 1, type: .string, value: "str")

        let resp = Response<[FeatureEnvironmentCollection]>(statusCode: 236,
          header: ["Content-Type": "application/json"],
          body: [FeatureEnvironmentCollection(id: UUID(), features: [f1]), FeatureEnvironmentCollection(id: UUID(), features: [f2])], bodyData: nil)

        stubResp(resp)

        stub(repository) { r in
          r.updateFeatures(any()).thenDoNothing()
        }

        await edge.poll()
        expect(edge._stopped).to(beTrue())

        verify(repository).updateFeatures(equal(to: [f1, f2]))
      }


      describe("empty data") {
        it("should update the cache timeout to 300 seconds") {
          await emptyDataCall(code: 200, ["cache-control": "private, max-age=300"])
          expect(edge.timeoutInSeconds) == 300
          verify(repository).empty()
        }

        it("should pass a failure back on a 400") {
          await emptyDataCall(code: 400)
          await edge.poll()
          await edge.poll()
          expect(edge._stopped).to(beTrue())
          verify(repository).notify(status: equal(to: .failure))
        }

        it("should pass a failure back on a 404") {
          await emptyDataCall(code: 404)
          await edge.poll()
          await edge.poll()
          expect(edge._stopped).to(beTrue())
          verify(repository).notify(status: equal(to: .failure))
        }

        it("should do nothing on a 502") {
          await emptyDataCall(code: 502)
          expect(edge._stopped).to(beFalse())
        }
      }
    }

    it("should not poll if the cache has not timed out") {
      edge.ensureCacheNotExpired()

      await edge.poll() // should do nothing
    }

    describe("etag") {
      let actualEtag  = "1234/456/8910"

      it("should grab the etag header") {
        await emptyDataCall(code: 200, ["etag": actualEtag])
        expect(edge.etag) == actualEtag
      }

      it("should send the etag header if one is set") {
        etag = actualEtag
        edge.etag = actualEtag
        await emptyDataCall(code: 200, ["etag": "newtag"])
        expect(edge.etag) == "newtag"
      }

      it("should poll immediately if the context has changed and update the x-featurehub header") {
        contextSha = "42144f3939c3ffbbf0bf8b1f12affb5c23a4c5bd41e0ff672d54a5754f062058"
        await emptyDataCall(code: 200, [:], doPoll: false)
        await edge.context_change("a=b")
      }
    }
  }
}
