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
      verifyNoMoreInteractions(requestor)
      verifyNoMoreInteractions(repository)
      verifyNoMoreInteractions(config)
    }

    describe("the api is called") {
      afterEach {
        verify(config).apiKeys.get()
        verify(config).baseUrl.get()
        verify(requestor).getFeatureStates(apiKeys: ["x"], contextSha: "0")
      }

      func stubResp(_ resp: Response<[FeatureEnvironmentCollection]>) {
        stub(requestor) { r in
          r.getFeatureStates(apiKeys: ["x"], contextSha: "0").thenReturn(resp)
        }
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

        verify(repository).updateFeatures(equal(to: [f1, f2]))
      }

      describe("error conditions") {
        func errorCondition(code: Int) async {
          let resp = Response<[FeatureEnvironmentCollection]>(statusCode: code,
            header: ["Content-Type": "application/json"],
            body: [FeatureEnvironmentCollection(id: UUID())], bodyData: nil)

          stubResp(resp)

          stub(repository) { r in
            r.notify(status: any()).thenDoNothing()
          }

          await edge.poll()
        }

        it("should pass a failure back on a 400") {
          await errorCondition(code: 400)
          verify(repository).notify(status: equal(to: .failure))
        }

        it("should pass a failure back on a 404") {
          await errorCondition(code: 404)
          verify(repository).notify(status: equal(to: .failure))
        }

        it("should do nothing on a 502") {
          await errorCondition(code: 502)
        }
      }
    }

    it("should not poll if the cache has not timed out") {
      edge.ensureCacheNotExpired()

      await edge.poll() // should do nothing
    }
  }
}
