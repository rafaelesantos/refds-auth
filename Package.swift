// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RefdsAuth",
    defaultLocalization: "pt",
    platforms: [
        .iOS(.v17),
        .macCatalyst(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1),
        .driverKit(.v23)
    ],
    products: [
        .library(
            name: "RefdsAuth",
            targets: ["RefdsAuth"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rafaelesantos/refds-shared.git", branch: "main"),
        .package(url: "https://github.com/rafaelesantos/refds-design-system.git", branch: "main")
    ],
    targets: [
        .target(
            name: "RefdsAuth",
            dependencies: [
                .product(name: "RefdsShared", package: "refds-shared"),
                .product(name: "RefdsUI", package: "refds-design-system")
            ]),
    ]
)
