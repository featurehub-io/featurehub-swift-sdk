//
// Created by richard on 18/03/23.
//

import Foundation
@testable import featurehub_swift_sdk
import Quick
import Nimble
import Cuckoo
import Logging

final class ServerContextTests : QuickSpec {
    override func spec() {
        describe("Server context trigger as expected") {
            var repo: MockInternalFeatureRepository!
            var edge: MockEdgeService!
            var ctx: ServerEvalFeatureContext!

            beforeEach {
                repo = MockInternalFeatureRepository()
                edge = MockEdgeService()

                stub(repo) { r in
                    r.notReady().thenDoNothing()
                }

                ctx = ServerEvalFeatureContext(repo, edge)
            }

            it("a build with an empty context works sends an empty header") {
                stub(edge) { e in
                    e.context_change(equal(to: "")).thenDoNothing()
                }

                await ctx.build()

                verify(edge).context_change(equal(to: ""))
                verify(repo).notReady()
            }

            it("a build with attributes sends a correct header, if the context does not change the new header won't trigger a rebuild") {
                ctx.user("beatport").country(.turkey).attribute("dj", "elif").attributes("channels", ["youtube", "soundcloud", "insta"])

                let expected = "channels=youtube%2Csoundcloud%2Cinsta,country=turkey,dj=elif,userkey=beatport"

                stub(edge) { e in
                    e.context_change(equal(to: expected)).thenDoNothing()
                }

                await ctx.build()
                await ctx.build()

                verify(edge).context_change(equal(to: expected))
                verify(repo).notReady()
            }

            it("a context with complex data is url encoded") {
                ctx.user("beat%port").country(.turkey).attribute("dj", "el=,if")

                let expected = "country=turkey,dj=el%3D%2Cif,userkey=beat%port"

                stub(edge) { e in
                    e.context_change(equal(to: expected)).thenDoNothing()
                }

                await ctx.build()
                await ctx.build()

                verify(edge).context_change(equal(to: expected))
                verify(repo).notReady()
            }

            it("a usage request sends a poll to the edge service") {
                let key = "F"
                let id = UUID()
                let val = 5
                let valueType = FeatureValueType.number

                stub(edge) { e in
                    e.poll().thenDoNothing()
                }

                await ctx.used(key, id, val, valueType)

                verify(edge).poll()
            }
        }
    }
}