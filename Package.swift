// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "PublishSwift",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "PublishSwift",
            targets: ["PublishSwift"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/flyer2001/Publish.git", from: "0.9.3"),
        .package(url: "https://github.com/johnsundell/splashpublishplugin", from: "0.2.0")
    ],
    targets: [
        .executableTarget(
            name: "PublishSwift",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                .product(name: "SplashPublishPlugin", package: "splashpublishplugin")
            ]
        )
    ]
)
