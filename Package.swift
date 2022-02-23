// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "NativeUIKit",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "NativeUIKit", targets: ["NativeUIKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ivanvorobei/SparrowKit", .upToNextMajor(from: "3.5.8")),
        .package(url: "https://github.com/ivanvorobei/SPPerspective", .upToNextMajor(from: "1.4.1")),
        .package(url: "https://github.com/ivanvorobei/SPDiffable", .upToNextMajor(from: "4.0.7")),
        .package(url: "https://github.com/ivanvorobei/SPPageController", .upToNextMajor(from: "1.3.2"))
    ],
    targets: [
        .target(
            name: "NativeUIKit",
            dependencies: [
                .product(name: "SparrowKit", package: "SparrowKit"),
                .product(name: "SPPerspective", package: "SPPerspective"),
                .product(name: "SPDiffable", package: "SPDiffable"),
                .product(name: "SPPageController", package: "SPPageController")
            ],
            swiftSettings: [
                .define("NATIVEUIKIT_SPM")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
