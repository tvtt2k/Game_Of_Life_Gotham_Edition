// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Theming",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Theming",
            targets: ["Theming"]
        ),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "Theming",
            dependencies: [],
            resources: [
                .process("Resources/Colors.xcassets")
            ]
        ),
        .testTarget(
            name: "ThemingTests",
            dependencies: ["Theming"]
        ),
    ]
)
