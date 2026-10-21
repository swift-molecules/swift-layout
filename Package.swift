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
        .library(name: "Layout", targets: ["Layout"]),
        .library(
            name: "Layout Standard Library Integration",
            targets: ["Layout Standard Library Integration"]
        ),
        .library(
            name: "Layout Apple Foundation Integration",
            targets: ["Layout Apple Foundation Integration"]
        ),
    ],
    traits: [
        .trait(name: "Boundary", description: "Boundary integration")
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-boundary.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-axis.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-direction.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-geometry.git",
            branch: "main"
        ),
    ],
    targets: [
        .testTarget(
            name: "Layout Boundary Tests",
            dependencies: [
                .target(name: "Layout"),
                .product(name: "Boundary", package: "swift-boundary", condition: .when(traits: ["Boundary"])),
            ],
            path: "Tests/Layout Boundary Tests"
        ),
        .target(
            name: "Layout",
            dependencies: [
                .product(name: "Boundary", package: "swift-boundary", condition: .when(traits: ["Boundary"])),
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Geometry", package: "swift-geometry"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Layout Standard Library Integration",
            dependencies: [
                .target(name: "Layout"),
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Layout Apple Foundation Integration",
            dependencies: [
                .target(name: "Layout"),
                .target(name: "Layout Standard Library Integration"),
            ]
        ),
        .testTarget(
            name: "Layout Tests",
            dependencies: [
                .target(name: "Layout"),
                .target(name: "Layout Standard Library Integration"),
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Geometry", package: "swift-geometry"),
                .product(
                    name: "Tagged",
                    package: "swift-tagged"
                ),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableUpcomingFeature("InferIsolatedConformances"),
            .enableExperimentalFeature("Lifetimes"),
            .treatAllWarnings(as: .error),
        ]
}
