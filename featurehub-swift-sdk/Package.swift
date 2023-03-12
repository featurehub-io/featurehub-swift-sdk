// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "featurehub-swift-sdk",
        platforms: [
            .iOS(.v11),
            .macOS(.v11),
            .tvOS(.v11),
            .watchOS(.v4),
        ],
        products: [
            // Products define the executables and libraries produced by a package, and make them visible to other packages.
            .library(name: "featurehub-swift-sdk", targets: ["featurehub-swift-sdk"]),
        ],
        dependencies: [
            // Dependencies declare other packages that this package depends on.
            .package(url: "https://github.com/Flight-School/AnyCodable", .upToNextMajor(from: "0.6.7")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "11.2.1")),
            .package(url: "https://github.com/Brightify/Cuckoo.git", .upToNextMajor(from: "1.9.1")),
            .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "6.1.0")),
            .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.5.2"))
        ],

        targets: [
            // Targets are the basic building blocks of a package. A target can define a module or a test suite.
            // Targets can depend on other targets in this package, and on products in packages which this package depends on.
            .target(
                    name: "featurehub-swift-sdk",
                    dependencies: ["AnyCodable", .product(name: "Logging", package: "swift-log") ],
                    exclude: ["pom.xml", "swift-api/Cartfile", "swift-api/README.md"]
            ),
            .testTarget(
                    name: "featurehub-swift-sdkTests",
                    dependencies: ["featurehub-swift-sdk", "Nimble", "Cuckoo", "Quick"]),
        ]
)
