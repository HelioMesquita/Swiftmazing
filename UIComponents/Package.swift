// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIComponents",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UIComponents",
            targets: ["UIComponents"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.19.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.15.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UIComponents",
            dependencies: [
                .product(name: "SDWebImage", package: "SDWebImage"),
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "UIComponentsTests",
            dependencies: [
                "UIComponents",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            path: "Tests"
        ),
    ]
)
