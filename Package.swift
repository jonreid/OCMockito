// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "OCMockito",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v9),
        .tvOS(.v12),
        .watchOS(.v2)
    ],
    products: [
        .library(name: "OCMockito", targets: ["OCMockito"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/hamcrest/OCHamcrest",
            .upToNextMajor(from: "9.0.0")
        ),
    ],
    targets: [
        .target(
            name: "OCMockito",
            dependencies: ["OCHamcrest"],
            path: "Source",
            exclude: [
                "Tests",
                "MakeDistribution.sh",
                "makeXCFramework.sh",
                "OCMockito-Info.plist",
                "Tests-Info.plist",
                "XcodeWarnings.xcconfig",
            ],
            sources: [
                "OCMockito",
            ],
            publicHeadersPath: "include",
            cSettings: [
                CSetting.headerSearchPath("OCMockito/Core"),
                CSetting.headerSearchPath("OCMockito/Helpers/ArgumentGetters"),
                CSetting.headerSearchPath("OCMockito/Helpers/ReturnValueSetters"),
                CSetting.headerSearchPath("OCMockito/Invocation"),
                CSetting.headerSearchPath("OCMockito/Mocking"),
                CSetting.headerSearchPath("OCMockito/Stubbing"),
                CSetting.headerSearchPath("OCMockito/Verifying"),
            ]
        ),
    ]
)
