// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-error-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Error Primitives",
            targets: ["Error Primitives"]
        ),
    ],
    targets: [
        .target(
            name: "Error Primitives",
            dependencies: []
        ),
        .testTarget(
            name: "Error Primitives Tests",
            dependencies: ["Error Primitives"],
            path: "Tests/Error Primitives Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .strictMemorySafety(),
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
