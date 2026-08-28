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
            name: "Layout Standard Library Integration",
            targets: ["Layout Standard Library Integration"]
        ),
        .library(
            name: "Layout Apple Foundation Integration",
            targets: ["Layout Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-axis.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-dimension.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-geometry.git",
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
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Layout Standard Library Integration",
            dependencies: [
                "Layout",
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Axis Standard Library Integration", package: "swift-axis"),
                .product(name: "Dimension", package: "swift-dimension"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Tagged Standard Library Integration", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Layout Apple Foundation Integration",
            dependencies: [
                "Layout",
                "Layout Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Layout Tests",
            dependencies: [
                "Layout",
                "Layout Standard Library Integration",
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Dimension", package: "swift-dimension"),
                .product(name: "Geometry", package: "swift-geometry"),
                .product(
                    name: "Tagged Standard Library Integration",
                    package: "swift-tagged"
                ),
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
