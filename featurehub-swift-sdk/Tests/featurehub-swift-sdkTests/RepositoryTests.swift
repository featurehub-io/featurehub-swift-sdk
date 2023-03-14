//
// Created by richard on 12/03/23.
//

import Foundation
@testable import featurehub_swift_sdk
import Quick
import Nimble
import Cuckoo
import Logging

final class RepositoryTests: QuickSpec {
  override func spec() {
    var repo: Repository!

    beforeSuite {
      LoggingSystem.bootstrap(StreamLogHandler.standardError)
      logger.logLevel = .trace
    }

    beforeEach {
      repo = Repository()
    }

    describe("with a ready repository") {
      beforeEach {
        repo.updateFeatures([FeatureState(id: UUID(), key: "bool", l: false, version: 1, type: .boolean, value: true)])
        expect(repo.readiness).to(equal(.ready))
      }

      it("should fail if we get a failure result") {
        repo.notify(status: .failure)
        expect(repo.readiness).to(equal(.failed))
      }
    }

    describe("with a notready repositroy") {
      it("should not be ready by default") {
        expect(repo.readiness).to(equal(.notReady))
      }

      it("should fail if we get a failure result") {
        repo.notify(status: .failure)
        expect(repo.readiness).to(equal(.failed))
      }

      it("should fail if we get a failure result") {
        repo.notify(status: .error)
        expect(repo.readiness).to(equal(.failed))
      }
    }

    it("should accept features and become ready") {
      let f1 = FeatureState(id: UUID(), key: "bool", l: false, version: 1, type: .boolean, value: true)
      let f2 = FeatureState(id: UUID(), key: "str", l: false, version: 1, type: .string, value: "str")
      repo.updateFeatures([f1, f2])
      expect(repo.feature("bool").exists).to(equal(true))
      expect(repo.feature("str").exists).to(equal(true))
      expect(repo.feature("fred")).toNot(beNil())
      expect(repo.feature("fred").exists).to(equal(false))
      expect(repo.readiness).to(equal(.ready))
    }

    describe("update a feature able it has been loaded") {
      var f1: FeatureState!
      var feat: RepositoryFeatureState!

      beforeEach {
        f1 = FeatureState(id: UUID(), key: "bool", l: false, version: 1, type: .boolean, value: true)
        repo.updateFeatures([f1])
        feat = repo.feature("bool")

        expect(feat.enabled).to(beTrue())
        expect(feat.version).to(equal(1))
        expect(feat.locked).to(beFalse())
        expect(feat.exists).to(beTrue())
      }

      it("should be able to load and be replaced") {
        repo.updateFeature(FeatureState(id: f1.id, key: "bool", l: true, version: 2, type: .boolean, value: false))
        expect(feat.enabled).to(beFalse())
        expect(feat.version).to(equal(2))
        expect(feat.locked).to(beTrue())
      }

      it("update a feature and it won't change if the version and value hasn't changed") {
        repo.updateFeature(FeatureState(id: f1.id, key: "bool", l: true, version: 1, type: .boolean, value: true))
        expect(feat.enabled).to(beTrue())
        expect(feat.version).to(equal(1))
        expect(feat.locked).to(beFalse())
      }

      it("should update if the value has changed but the version stays the same") {
        repo.updateFeature(FeatureState(id: f1.id, key: "bool", l: true, version: 1, type: .boolean, value: false))
        expect(feat.enabled).to(beFalse())
        expect(feat.version).to(equal(1))
        expect(feat.locked).to(beTrue())
      }

      it("should not exist if the feature is deleted") {
        repo.deleteFeature(FeatureState(id: f1.id, key: "bool", l: true, version: 1, type: .boolean, value: false))
        expect(feat.exists).to(beFalse())
      }
    }


    describe("allow features to be loaded") {
      describe("flag features") {
        var raw: FeatureState!
        var feat: RepositoryFeatureState!

        beforeEach {
          raw = FeatureState(id: UUID(), key: "bool", l: false, version: 1, type: .boolean, value: true)
          repo.updateFeatures([raw])
          feat = repo.feature("bool")
        }

        it("basic checks") {
          expect(feat).toNot(beNil())
          expect(feat.exists).to(equal(true))
          expect(feat.enabled).to(beTrue())
          expect(feat.flag).to(beTrue())
          expect(feat.string).to(beNil())
          expect(feat.json).to(beNil())
          expect(feat.number).to(beNil())
          expect(feat.version).to(equal(1))
          expect(feat.locked).to(beFalse())
          expect(feat.hasValue).to(beTrue())
          expect(feat.id).to(equal(raw.id))
          expect(feat.featureType).to(equal(.boolean))
        }
      }

      describe("string features") {
        var raw: FeatureState!
        var feat: RepositoryFeatureState!

        beforeEach {
          raw = FeatureState(id: UUID(), key: "str", l: false, version: 1, type: .string, value: "swift")
          repo.updateFeatures([raw])
          feat = repo.feature("str")
        }

        it("basic checks") {
          expect(feat).toNot(beNil())
          expect(feat.exists).to(equal(true))
          expect(feat.enabled).to(beFalse())
          expect(feat.flag).to(beNil())
          expect(feat.string).to(equal("swift"))
          expect(feat.json).to(beNil())
          expect(feat.number).to(beNil())
          expect(feat.version).to(equal(1))
          expect(feat.locked).to(beFalse())
          expect(feat.hasValue).to(beTrue())
          expect(feat.id).to(equal(raw.id))
          expect(feat.featureType).to(equal(.string))
        }
      }

      describe("number features") {
        var raw: FeatureState!
        var feat: RepositoryFeatureState!

        beforeEach {
          raw = FeatureState(id: UUID(), key: "num", l: false, version: 1, type: .number, value: 38.4)
          repo.updateFeatures([raw])
          feat = repo.feature("num")
        }

        it("basic checks") {
          expect(feat).toNot(beNil())
          expect(feat.exists).to(equal(true))
          expect(feat.enabled).to(beFalse())
          expect(feat.flag).to(beNil())
          expect(feat.string).to(beNil())
          expect(feat.json).to(beNil())
          expect(feat.number).to(equal(38.4))
          expect(feat.version).to(equal(1))
          expect(feat.locked).to(beFalse())
          expect(feat.hasValue).to(beTrue())
          expect(feat.id).to(equal(raw.id))
          expect(feat.featureType).to(equal(.number))
        }
      }

      describe("number features") {
        var raw: FeatureState!
        var feat: RepositoryFeatureState!

        beforeEach {
          raw = FeatureState(id: UUID(), key: "json", l: true, version: 2, type: .json, value: "{\"fred\": 26}")
          repo.updateFeatures([raw])
          feat = repo.feature("json")
        }

        it("basic checks") {
          expect(feat).toNot(beNil())
          expect(feat.exists).to(equal(true))
          expect(feat.enabled).to(beFalse())
          expect(feat.flag).to(beNil())
          expect(feat.string).to(beNil())
          expect(feat.json).to(equal("{\"fred\": 26}"))
          expect(feat.number).to(beNil())
          expect(feat.version).to(equal(2))
          expect(feat.locked).to(beTrue())
          expect(feat.hasValue).to(beTrue())
          expect(feat.id).to(equal(raw.id))
          expect(feat.featureType).to(equal(.json))
        }
      }
    }

  }
}
