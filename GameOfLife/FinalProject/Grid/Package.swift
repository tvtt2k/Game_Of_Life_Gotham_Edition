// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "Grid",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Grid",
            targets: ["Grid"]),
    ],
    dependencies: [
        .package(path: "../GameOfLife"),
        .package(path: "../Theming"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.16.1")
    ],
    targets: [
        .target(
            name: "Grid",
            dependencies: [
                "GameOfLife",
                "Theming",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "GridTests",
            dependencies: ["Grid"]),
    ]
)
