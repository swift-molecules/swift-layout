// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-layout",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Layout",
            targets: ["Layout"]
        ),
        .library(
            name: "Layout Test Support",
            targets: ["Layout Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-axis.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-dimension.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-geometry.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-boundary.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Layout",
            dependencies: [
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Dimension", package: "swift-dimension"),
                .product(name: "Geometry", package: "swift-geometry"),
                .product(name: "Boundary", package: "swift-boundary"),
            ]
        ),
        .target(
            name: "Layout Test Support",
            dependencies: [
                "Layout",
                .product(
                    name: "Dimension Test Support",
                    package: "swift-dimension"
                ),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Layout Tests",
            dependencies: [
                "Layout",
                "Layout Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
