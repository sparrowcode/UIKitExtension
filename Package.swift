// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "NativeUIKit",
    platforms: [
        .iOS(.v12), .tvOS(.v12), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "NativeUIKit",
            targets: ["NativeUIKit"]
        )
    ],
    dependencies: [
        .package(name: "SparrowKit", url: "https://github.com/ivanvorobei/SparrowKit", .upToNextMajor(from: "3.2.2")),
        .package(name: "SPPerspective", url: "https://github.com/ivanvorobei/SPPerspective", .upToNextMajor(from: "1.3.5")),
    ],
    targets: [
        .target(
            name: "NativeUIKit",
            dependencies: [
                .product(name: "SparrowKit", package: "SparrowKit"),
                    .product(name: "SPPerspective", package: "SPPerspective")
            ],
            swiftSettings: [
                .define("NATIVEUIKIT_SPM")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
