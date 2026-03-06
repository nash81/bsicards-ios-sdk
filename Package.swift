// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "BSICards",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BSICards",
            targets: ["BSICards"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BSICards",
            dependencies: [],
            path: "Sources/BSICards"
        ),
        .testTarget(
            name: "BSICardsTests",
            dependencies: ["BSICards"],
            path: "Tests"
        )
    ]
)

