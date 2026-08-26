# Layout

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Layout primitives for Swift — direction-aware alignments, edges, and corners that adapt to text direction, expressed as a small namespace of value types. Foundation-free and Embedded-compatible.

## Installation

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-layout.git", branch: "main")
]
```

Add the product to your target:

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Layout", package: "swift-layout")
    ]
)
```

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
