// swift-tools-version: 6.2

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "LocalPackage",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v26),
    ],
    products: [
        .library(
            name: "DataSource",
            targets: ["DataSource"]
        ),
        .library(
            name: "Model",
            targets: ["Model"]
        ),
        .library(
            name: "UserInterface",
            targets: ["UserInterface"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", exact: "1.8.0"),
        .package(url: "https://github.com/Kyome22/DeviceModel.git", exact: "1.2.0"),
        .package(url: "https://github.com/Kyome22/SystemInfoKit.git", exact: "6.8.0"),
    ],
    targets: [
        .target(
            name: "DataSource",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "SystemInfoKit", package: "SystemInfoKit"),
            ],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "Model",
            dependencies: [
                "DataSource",
                .product(name: "DeviceModel", package: "DeviceModel"),
            ],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "UserInterface",
            dependencies: [
                "DataSource",
                "Model",
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "DataSourceTests",
            dependencies: [
                "DataSource"
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "ModelTests",
            dependencies: [
                "Model",
            ],
            swiftSettings: swiftSettings
        ),
    ]
)
