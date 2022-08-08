// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "UIKitExtension",
    platforms: [
        .iOS(.v13), 
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "UIKitExtension",
            targets: ["UIKitExtension"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/sparrowcode/SwiftBoost", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/sparrowcode/DiffableKit", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "UIKitExtension",
            dependencies: [
                .product(name: "SwiftBoost", package: "SwiftBoost"),
                .product(name: "DiffableKit", package: "DiffableKit")
            ],
            swiftSettings: [
                .define("UIKITEXTENSION_SPM")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
