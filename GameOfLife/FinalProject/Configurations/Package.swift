// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Configurations",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Configurations",
            targets: ["Configurations"]
        ),
    ],
    dependencies: [
        .package(path: "../Configuration"),
        .package(path: "../Theming"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.16.1")
    ],
    targets: [
        .target(
            name: "Configurations",
            dependencies: [
                "Configuration",
                "Theming",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "ConfigurationsTests",
            dependencies: ["Configurations"]),
    ]
)
