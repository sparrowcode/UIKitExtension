// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "UIKitExtension",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "UIKitExtension", targets: ["UIKitExtension"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UIKitExtension",
            swiftSettings: [
                .define("UIKITEXTENSION_SPM")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
