// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "reorder",
    dependencies: [
      .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50100.0")),
      .package(url: "https://github.com/apple/indexstore-db.git", .branch("swift-5.1-branch")) // missing semver tag
    ],
    targets: [
        .target(name: "reorder", dependencies: ["Engine"]),
        .target(name: "Utils", dependencies: ["SwiftSyntax"]),
        .target(name: "Engine", dependencies: ["SwiftSyntax", "Utils", "IndexStoreDB"]),
        .testTarget(name: "ReorderTests", dependencies: ["reorder"]),

        .target(name: "Conference")
    ]
)
