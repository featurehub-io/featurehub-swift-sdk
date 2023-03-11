import XCTest
@testable import featurehub_swift_sdk
import Nimble
import Cuckoo

final class featurehub_swift_sdkTests: XCTestCase {
//    func testExample() throws {
//        let repo = MockFeatureRepository()
//        let ctx = ClientContext(repo)
//        ctx.user("me")
//        expect(ctx.attributes["userKey"]).to(beNil())
//        expect(ctx.attributes["userkey"]).to(equal(["me"]))
//    }

    func testSDK() async {
        let config = EdgeFeatureHubConfig("http://localhost:8085",
                ["8c5d3253-4974-4455-a684-954ce6a6110d/EWddcsNnNza60FVIocq62ApdrzKlr9qxCfSlo323"])
        let ctx = config.newContext()
        await ctx.build()
        print("repository is \(config.repository.readiness)")
        print("repository feature \(config.repository.feature("uppercase_text"))")
        expect(ctx.feature("uppercase_text")?.enabled).to(equal(true))
    }
}
