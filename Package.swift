// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "reorder",
    dependencies: [
      .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50100.0")),
    ],
    targets: [
        .target(name: "reorder", dependencies: ["Engine"]),
        .target(name: "Utils", dependencies: ["SwiftSyntax"]),
        .target(name: "Engine", dependencies: ["SwiftSyntax", "Utils"]),
        .testTarget(name: "ReorderTests", dependencies: ["reorder"]),

        .target(name: "Conference")
    ]
)
