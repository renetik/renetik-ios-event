// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RenetikEvent",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RenetikEvent",
            targets: ["RenetikEvent"]),
    ],
    dependencies: [
        .package(url: "https://github.com/renetik/renetik-ios-core", from: "0.9.10"),
    ],
    targets: [
        .target(
            name: "RenetikEvent",
            dependencies: [.product(name: "RenetikCore", package: "renetik-ios-core")]
        ),
        .testTarget(
            name: "RenetikEventTests",
            dependencies: ["RenetikEvent"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
