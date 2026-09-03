//
// Reproduces the crash seen in the wild where the repository dictionaries were
// mutated from the polling task at the same time as the UI thread asked for
// features (swift_isUniquelyReferenced_nonNull_native inside updateFeature).
//

import Foundation
@testable import featurehub_swift_sdk
import AnyCodable
import Quick
import Nimble

final class RepositoryConcurrencyTests: QuickSpec {
  override func spec() {
    describe("a repository used from several threads at once") {
      let featureCount = 50
      let rounds = 200

      it("survives features being read while the edge updates them") {
        let repo = Repository()
        let ids = (0..<featureCount).map { _ in UUID() }

        DispatchQueue.concurrentPerform(iterations: 8) { worker in
          for round in 0..<rounds {
            if worker % 2 == 0 { // pretend to be the edge service polling
              repo.updateFeatures((0..<featureCount).map { i in
                FeatureState(id: ids[i], key: "feature-\(i)", l: false,
                  version: Int64(round), type: .boolean, value: AnyCodable(round % 2 == 0))
              })
            } else { // pretend to be the UI asking for features
              for i in 0..<featureCount {
                _ = repo.feature("feature-\(i)").enabled
                _ = repo.feature("never-exists-\(i)").exists
              }
            }
          }
        }

        expect(repo.readiness).to(equal(.ready))
        for i in 0..<featureCount {
          expect(repo.feature("feature-\(i)").exists).to(beTrue())
          expect(repo.feature("feature-\(i)").id).to(equal(ids[i]))
        }
      }
    }
  }
}
