// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Example",
    products: [
        .library(
            name: "Example",
            targets: ["Example"]),
    ],
    // begin-snippet: swiftpm-declare-dependencies
    dependencies: [
        .package(
            url: "https://github.com/jonreid/OCMockito",
            .upToNextMajor(from: "7.0.0")
        ),
    ],
    // end-snippet
    targets: [
        .target(
            name: "Example",
            dependencies: [],
            publicHeadersPath: "./"
        ),
        // begin-snippet: swiftpm-use-dependencies
        .testTarget(
            name: "ExampleTests",
            dependencies: [
                "Example",
                "OCMockito",
            ]
        ),
        // end-snippet
    ]
)
