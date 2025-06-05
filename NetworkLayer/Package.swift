// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NetworkLayer",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "NetworkLayer",
      targets: ["NetworkLayer"])
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "NetworkLayer",
      swiftSettings: [
        .unsafeFlags(["-Xfrontend", "-enable-actor-data-race-checks"]),
        .unsafeFlags(["-Xfrontend", "-strict-concurrency=complete"]),
        .unsafeFlags(["-swift-version", "6"]),
      ]
    ),
    .testTarget(
      name: "NetworkLayerTests",
      dependencies: ["NetworkLayer"]),
  ]
)
