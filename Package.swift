// swift-tools-version: 5.6
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
        .package(url: "https://github.com/renetik/renetik-ios-core", exact: "0.9.3" ),
    ],
    targets: [
        .target(
            name: "RenetikEvent",
            dependencies: [
                .product(name: "RenetikCore", package: "renetik-ios-core"),
            ]
        ),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
