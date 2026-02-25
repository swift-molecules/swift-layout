// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-layout-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Layout Primitives",
            targets: ["Layout Primitives"]
        )
    ],
    dependencies: [
        .package(path: "../swift-dimension-primitives"),
        .package(path: "../swift-positioning-primitives"),
        .package(path: "../swift-geometry-primitives"),
        .package(path: "../swift-region-primitives")
    ],
    targets: [
        .target(
            name: "Layout Primitives",
            dependencies: [
                .product(name: "Dimension Primitives", package: "swift-dimension-primitives"),
                .product(name: "Positioning Primitives", package: "swift-positioning-primitives"),
                .product(name: "Geometry Primitives", package: "swift-geometry-primitives"),
                .product(name: "Region Primitives", package: "swift-region-primitives")
            ]
        ),
        .testTarget(
            name: "Layout Primitives Tests",
            dependencies: [
                "Layout Primitives",
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
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableExperimentalFeature("SuppressedAssociatedTypesWithDefaults"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
