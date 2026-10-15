//
// Created by richard on 18/03/23.
//

import Foundation

@testable import featurehub_swift_sdk
import Quick
import Nimble
import Cuckoo
import AnyCodable


// an edge for contexts whose features are used, which polls
private final class IdleEdge: EdgeService {
    func poll() async {
    }

    func context_change(_ new_header: String) async {
    }

    func close() {
    }
}

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
                // a holder made for a context has no state of its own, it reports the state it wraps
                expect(child.exists) == true
                expect(child.id) == f1.id
                expect(child.version) == 1
                expect(child.locked) == false
                expect(child.featureType) == .boolean
                expect(child.hasValue) == true
                expect(child.featureState?.id) == f1.id
            }
        }

        describe("features asked for through a server evaluated context") {
            var repo: Repository!
            var ctx: ServerEvalFeatureContext!

            beforeEach {
                repo = Repository()
                ctx = ServerEvalFeatureContext(repo, IdleEdge())
            }

            it("report the feature's state") {
                let f1 = FeatureState(id: UUID(), key: "str", l: true, version: 3, type: .string, value: "hello")
                repo.updateFeatures([f1])

                let feat = ctx.feature("str")
                expect(feat.exists) == true
                expect(feat.id) == f1.id
                expect(feat.version) == 3
                expect(feat.locked) == true
                expect(feat.featureType) == .string
                expect(feat.hasValue) == true
                expect(feat.string) == "hello"
                expect(ctx.exists("str")) == true
                expect(ctx.hasValue("str")) == true
            }

            it("report a feature that hasn't arrived yet as missing, and pick it up when it does") {
                let feat = ctx.feature("later")
                expect(feat.exists) == false
                expect(feat.id).to(beNil())
                expect(feat.version) == -1
                expect(feat.locked) == false
                expect(feat.featureType).to(beNil())
                expect(feat.hasValue) == false

                let f1 = FeatureState(id: UUID(), key: "later", l: false, version: 1, type: .boolean, value: true)
                repo.updateFeatures([f1])
                expect(feat.exists) == true
                expect(feat.id) == f1.id
                expect(feat.version) == 1
                expect(feat.featureType) == .boolean
                expect(feat.hasValue) == true
                expect(feat.enabled) == true
            }

            it("report a deleted feature as missing") {
                let f1 = FeatureState(id: UUID(), key: "gone", l: false, version: 1, type: .boolean, value: true)
                repo.updateFeatures([f1])
                let feat = ctx.feature("gone")
                expect(feat.exists) == true

                repo.deleteFeature(FeatureState(id: f1.id, key: "gone", l: false, version: 2, type: .boolean, value: nil))
                expect(feat.exists) == false
                expect(feat.hasValue) == false
                expect(ctx.exists("gone")) == false
            }
        }


    }
}