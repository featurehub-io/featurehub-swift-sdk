//
// Created by richard on 18/03/23.
//

import Foundation

@testable import featurehub_swift_sdk
import Quick
import Nimble
import Cuckoo
import AnyCodable


final class FeatureTests: QuickSpec {
    override func spec() {
        describe("features should function") {
            it("with context") {
                let f1 = FeatureState(id: UUID(), key: "swift", l: false, version: 1, type: .boolean, value: true)
                let repo = MockInternalFeatureRepository()
                let parent = FeatureStateHolder(key: f1.key, repo: repo)
                parent.setFeatureState(f1)
                let ctx = MockInternalContext()
                stub(ctx) { c in
                    c.used(f1.key, equal(to: f1.id), any(), equal(to: FeatureValueType.boolean)).thenDoNothing()
                }
                let child = parent.withContext(ctx: ctx)
                expect(child.enabled) == true
            }
        }


    }
}