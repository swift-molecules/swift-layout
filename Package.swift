// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-layout-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Layout Primitives",
            targets: ["Layout Primitives"]
        ),
        .library(
            name: "Layout Primitives Test Support",
            targets: ["Layout Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-axis-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-dimension-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-geometry-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-boundary-primitives.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Layout Primitives",
            dependencies: [
                .product(name: "Axis Primitives", package: "swift-axis-primitives"),
                .product(name: "Dimension Primitives", package: "swift-dimension-primitives"),
                .product(name: "Geometry Primitives", package: "swift-geometry-primitives"),
                .product(name: "Boundary Primitives", package: "swift-boundary-primitives"),
            ]
        ),
        .target(
            name: "Layout Primitives Test Support",
            dependencies: [
                "Layout Primitives",
                .product(
                    name: "Dimension Primitives Test Support",
                    package: "swift-dimension-primitives"
                ),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Layout Primitives Tests",
            dependencies: [
                "Layout Primitives",
                "Layout Primitives Test Support",
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
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
