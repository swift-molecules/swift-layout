// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-layout-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Layout Primitives",
            targets: ["Layout Primitives"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-dimension-primitives.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-positioning-primitives.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-geometry-primitives.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-region-primitives.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-test-primitives.git", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "Layout Primitives",
            dependencies: [
                .product(name: "Dimension Primitives", package: "swift-dimension-primitives"),
                .product(name: "Positioning Primitives", package: "swift-positioning-primitives"),
                .product(name: "Geometry Primitives", package: "swift-geometry-primitives"),
                .product(name: "Region Primitives", package: "swift-region-primitives"),
            ]
        ),
        .testTarget(
            name: "Layout Primitives Tests",
            dependencies: [
                "Layout Primitives",
                .product(name: "Test Primitives", package: "swift-test-primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
