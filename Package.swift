// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "OCMockito",
    platforms: [
        .macOS(.v10_13),
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
            .upToNextMajor(from: "9.1.1")
        ),
    ],
    targets: [
        .target(
            name: "OCMockito",
            dependencies: ["OCHamcrest"],
            cSettings: [
                .headerSearchPath("./Core"),
                .headerSearchPath("./Helpers/ArgumentGetters"),
                .headerSearchPath("./Helpers/ReturnValueSetters"),
                .headerSearchPath("./Invocation"),
                .headerSearchPath("./Mocking"),
                .headerSearchPath("./Stubbing"),
                .headerSearchPath("./Verifying")
            ]
        ),
        .testTarget(
            name: "OCMockitoTests",
            dependencies: ["OCMockito","OCHamcrest"],
            cSettings: [
                .headerSearchPath("./"),
                .headerSearchPath("../../Sources/OCMockito/Core"),
                .headerSearchPath("../../Sources/OCMockito/Invocation"),
                .headerSearchPath("../../Sources/OCMockito/Stubbing"),
                .headerSearchPath("../../Sources/OCMockito/Verifying")
            ]
        )
    ]
)
