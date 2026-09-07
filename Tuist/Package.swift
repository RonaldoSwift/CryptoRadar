// swift-tools-version: 6.3

import PackageDescription

#if TUIST 
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
        "Swinject": .framework
    ]
)
#endif




let package = Package(
    name: "CryptoRadarDependencies",
    dependencies: [
        .package(
            url: "https://github.com/airbnb/lottie-spm.git",
            from: "4.5.0"
        ),
        .package(
            url: "https://github.com/Swinject/Swinject.git",
            from: "2.9.0"
        )
    ]
)
