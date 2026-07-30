import ProjectDescription

let config = Config(
    compatibleXcodeVersions: [.exact("26.6")]
)

let project = Project(
    name: "CryptoRadar",
    organizationName: "RonaldoSwift",
    options: .options(disableSynthesizedResourceAccessors: true),
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.0"))
    ],
    targets: [
        Target.target(
            name: "CryptoRadar",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.ronaldo.CryptoRadar",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "CryptoRadar",
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1",
                "UILaunchScreen": [:]
            ]),
            sources: ["CryptoRadar/Sources/**"],
            resources: [
                "CryptoRadar/Resources/**",
                "CryptoRadar/Configs/Secrets.xcconfig"
            ],
            dependencies: [
                .target(name: "Login"),
                .target(name: "Register"),
                .target(name: "StorageKit"),
                .target(name: "CryptoList"),
                .target(name: "Detalle"),
                .target(name: "Favorite"),
                .target(name: "Configuracion")
            ],
            settings: .settings(configurations: [
                .debug(name: .debug, xcconfig: "CryptoRadar/Configs/Secrets.xcconfig"),
                .release(name: .release, xcconfig: "CryptoRadar/Configs/Secrets.xcconfig")
            ])
        ),
        Target.target(
            name: "Login",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.Login",
            deploymentTargets: .iOS("17.0"),
            sources: ["Features/Login/Sources/**"],
            resources: ["Features/Login/Resources/**"],
            dependencies: [
                .target(name: "StorageKit"),
                .package(product: "Swinject")
            ]
        ),
        Target.target(
            name: "Register",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.Register",
            deploymentTargets: .iOS("17.0"),
            sources: ["Features/Register/Sources/**"],
            resources: ["Features/Register/Resources/**"],
            dependencies: [
                .target(name: "StorageKit"),
                .package(product: "Swinject")
            ]
        ),
        Target.target(
            name: "CryptoList",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.CryptoList",
            deploymentTargets: .iOS("17.0"),
            sources: ["Features/CryptoList/Sources/**"],
            resources: ["Features/CryptoList/Resources/**"],
            dependencies: [
                .target(name: "Favorite"),
                .package(product: "Swinject")
            ]
        ),
        Target.target(
            name: "Detalle",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.Detalle",
            deploymentTargets: .iOS("17.0"),
            sources: ["Features/Detalle/Sources/**"],
            resources: ["Features/Detalle/Resources/**"],
            dependencies: [
                .target(name: "Favorite"),
                .package(product: "Swinject")
            ]
        ),
        Target.target(
            name: "Favorite",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.Favorite",
            deploymentTargets: .iOS("17.0"),
            sources: ["Features/Favorite/Sources/**"],
            resources: ["Features/Favorite/Resources/**"],
            dependencies: [
                .target(name: "StorageKit"),
                .package(product: "Swinject")
            ]
        ),
        Target.target(
            name: "Configuracion",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.Configuracion",
            deploymentTargets: .iOS("17.0"),
            sources: ["Features/Configuracion/Sources/**"],
            resources: ["Features/Configuracion/Resources/**"],
            dependencies: [
                .target(name: "StorageKit"),
                .package(product: "Swinject")
            ]
        ),
        Target.target(
            name: "StorageKit",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.StorageKit",
            deploymentTargets: .iOS("17.0"),
            sources: ["Shared/StorageKit/**"],
            resources: []
        ),
        Target.target(
            name: "NetworkKit",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.NetworkKit",
            deploymentTargets: .iOS("17.0"),
            sources: ["Shared/NetworkKit/**"],
            resources: []
        ),
        Target.target(
            name: "ImageKit",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.ImageKit",
            deploymentTargets: .iOS("17.0"),
            sources: ["Shared/ImageKit/**"],
            resources: []
        ),
        Target.target(
            name: "PersistenceKit",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.ronaldo.CryptoRadar.PersistenceKit",
            deploymentTargets: .iOS("17.0"),
            sources: ["Shared/PersistenceKit/**"],
            resources: []
        )
    ],
    schemes: [
        Scheme.scheme(name: "CryptoRadar", buildAction: .buildAction(targets: [.target(name: "CryptoRadar")]))
    ]
)
