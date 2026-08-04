// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "CryptoRadarDependencies",
    dependencies: [
        .package(
            url: "https://github.com/Swinject/Swinject.git",
            from: "2.9.0"
        )
    ]
)
