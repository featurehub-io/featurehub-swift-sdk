//
// Created by richard on 12/03/23.
//

import Foundation
@testable import featurehub_swift_sdk
import Quick
import Nimble
import Cuckoo
import Logging

final class ClientContextTests: QuickSpec {
  override func spec() {
    beforeSuite {
      LoggingSystem.bootstrap(StreamLogHandler.standardError)
      logger.logLevel = .trace
    }

    describe("client contexts should") {
      var repo: MockFeatureRepository!
      var ctx: ClientContext!

      beforeEach {
        repo = MockFeatureRepository()
        ctx = ClientContext(repo)
      }

      it("support all well known types") {
        ctx.user("me")
        expect(ctx.attributes["userKey"]).to(beNil())
        known(.userKey, "me")
        ctx.session("sample")
        known(.session, "sample")
        ctx.platform(.android)
        known(.platform, "android")
        ctx.device(.browser)
        known(.device, "browser")
        ctx.country(.albania)
        known(.country, "albania")
        ctx.version("50")
        known(.version, "50")
      }

      describe("support feature based proxying") {
        var feature: MockRepositoryFeatureState!

        beforeEach {
          feature = MockRepositoryFeatureState()
          stub(repo) { stub in
            when(stub.feature("feat")).thenReturn(feature)
          }
        }

        it("the feature") {
          expect(ctx.feature("feat")).toNot(beNil())
          verify(repo, times(1)).feature("feat")
        }

        it("enabled") {
          stub(feature) { stub in
            when(stub.enabled.get).thenReturn(true)
          }
          expect(ctx.enabled("feat")) == true
          verify(repo, times(1)).feature("feat")
        }
      }

      func known(_ key: ContextKeys, _ val: String) {
        expect(ctx.attributes[key.rawValue]).to(equal([val]))
      }
    }
  }
}
