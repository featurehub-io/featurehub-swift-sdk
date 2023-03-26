// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "featurehub_swift_sdk",
        platforms: [
            .iOS(.v13),
            .macOS(.v11),
            .tvOS(.v11),
            .watchOS(.v4),
        ],
        products: [
            .library(name: "featurehub_swift_sdk", targets: ["featurehub_swift_sdk"]),
        ],
        dependencies: [
            .package(url: "https://github.com/Flight-School/AnyCodable", .upToNextMajor(from: "0.6.7")),
            .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.5.2")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "11.2.1")),
            .package(url: "https://github.com/Brightify/Cuckoo.git", .upToNextMajor(from: "1.9.1")),
            .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "6.1.0"))
        ],

        targets: [
            // Targets are the basic building blocks of a package. A target can define a module or a test suite.
            // Targets can depend on other targets in this package, and on products in packages which this package depends on.
            .target(
                    name: "featurehub_swift_sdk",
                    dependencies: ["AnyCodable", .product(name: "Logging", package: "swift-log") ],
                    exclude: ["pom.xml", "swift-api/Cartfile", "swift-api/README.md"]
            ),
            .testTarget(
                    name: "featurehub_swift_sdkTests",
                    dependencies: ["featurehub_swift_sdk", "Nimble", "Cuckoo", "Quick"]),
        ]
)
