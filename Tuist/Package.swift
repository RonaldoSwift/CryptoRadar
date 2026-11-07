// swift-tools-version: 6.3

import PackageDescription

#if TUIST 
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
        "Swinject": .framework,
        "ImageKit": .framework,
        "Lottie": .framework
    ],
    baseSettings: .settings(
        base: [
            "IPHONEOS_DEPLOYMENT_TARGET": "17.0"
        ]
        ),
        targetSettings: [
            "_LottieStub": .settings(
                base: [
                    "IPHONEOS_DEPLOYMENT_TARGET": "17.0"
                ],
                debug: [
                    "IPHONEOS_DEPLOYMENT_TARGET": "17.0"
                ],
                release: [
                    "IPHONEOS_DEPLOYMENT_TARGET": "17.0"
                ]
            ),
            "Swinject": .settings(
                base: [
                    "IPHONEOS_DEPLOYMENT_TARGET": "17.0"
                ],
                debug: [
                    "IPHONEOS_DEPLOYMENT_TARGET": "17.0"
                ],
                release: [
                    "IPHONEOS_DEPLOYMENT_TARGET": "17.0"
                ]
            )
        ]
    )
#endif



let package = Package(
    name: "CryptoRadarDependencies",
    dependencies: [
        .package(
            url: "https://github.com/RonaldoSwift/image-kit-ios.git",
            from: "1.0.0"
        ),
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
