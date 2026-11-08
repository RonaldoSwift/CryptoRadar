import ProjectDescription

let project = Project(
    name: "CryptoRadar",
    
    targets: [
        .target(
            name: "CryptoRadar",
            destinations: .iOS,
            product: .app,
            bundleId: "com.ronaldoVargas.CryptoRadar",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .file(
                path: "CryptoRadar/Info.plist"
            ),
            sources: [
                "CryptoRadar/Sources/**"
            ],
            resources: [
                "CryptoRadar/Resources/**"
            ],
            dependencies: [
                .target(name: "Login"),
                .target(name: "Register"),
                .target(name: "CryptoList"),
                .target(name: "Detalle"),
                .target(name: "Favorite"),
                .target(name: "Configuracion"),
                .target(name: "StorageKit"),
                .target(name: "NetworkKit"),
                .target(name: "PersistenceKit"),
                .external(name:"Swinject")
            ],
            settings: .settings(
                configurations: [
                    .debug(
                        name: "Debug",
                        xcconfig: "CryptoRadar/Configs/Secrets.xcconfig"
                    ),
                    .release(
                        name: "Release",
                        xcconfig: "CryptoRadar/Configs/Secrets.xcconfig"
                    )
                ]
            )
        ),

        .target(
            name: "CryptoRadarUITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "com.ronaldoVargas.CryptoRadarUITests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: [
                "CryptoRadarUITests/**"
            ],
            dependencies: [
        .target(name: "CryptoRadar")
            ]
        ),
        
            .target(
                name: "StorageKit",
                destinations: .iOS,
                product: .framework,
                bundleId: "com.ronaldoVargas.StorageKit",
                deploymentTargets: .iOS("17.0"),
                infoPlist: .default,
                sources: [
                    "Shared/StorageKit/**"
                ],
                dependencies: [
                ]
            ),

        .target(
            name: "PersistenceKit",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldoVargas.PersistenceKit",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: [
                "Shared/PersistenceKit/**"
            ]
        ),
        
            .target(
                name: "NetworkKit",
                destinations: .iOS,
                product: .framework,
                bundleId: "com.ronaldoVargas.NetworkKit",
                deploymentTargets: .iOS("17.0"),
                infoPlist: .default,
                sources: [
                    "Shared/NetworkKit/**"
                ]
            ),
        
        // FEATURES
        
            .target(
                name: "Login",
                destinations: .iOS,
                product: .framework,
                bundleId: "com.ronaldoVargas.Login",
                deploymentTargets: .iOS("17.0"),
                infoPlist: .default,
                sources: [
                    "Features/Login/Sources/**"
                ],
                resources: [
                    "Features/Login/Resources/**"
                ],
                dependencies: [
                    .target(name: "StorageKit"),
                    .target(name: "NetworkKit"),
                    .external(name: "Swinject")
                ]
            ),
        
            .target(
                name: "LoginTests",
                destinations: .iOS,
                product: .unitTests,
                bundleId: "com.ronaldoVargas.LoginTests",
                deploymentTargets: .iOS("17.0"),
                infoPlist: .default,
                sources: [
                    "Features/LoginTests/**"
                ],
                dependencies: [
                    .target(name: "Login")
                ]
            ),
        
            .target(
                name: "Register",
                destinations: .iOS,
                product: .framework,
                bundleId: "com.ronaldoVargas.Register",
                deploymentTargets: .iOS("17.0"),
                infoPlist: .default,
                sources: [
                    "Features/Register/Sources/**"
                ],
                resources: [
                    "Features/Register/Resources/**"
                ],
                dependencies: [
                    .target(name: "StorageKit"),
                    .target(name: "NetworkKit"),
                    .external(name: "Swinject")
                ]
            ),
        
            .target(
                name: "RegisterTests",
                destinations: .iOS,
                product: .unitTests,
                bundleId: "com.ronaldoVargas.RegisterTests",
                deploymentTargets: .iOS("17.0"),
                infoPlist: .default,
                sources: [
                    "Features/RegisterTests/**"
                ],
                dependencies: [
                    .target(name: "Register")
                ]
            ),
        .target(
            name: "CryptoList",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldoVargas.CryptoList",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: [
                "Features/CryptoList/Sources/**"
            ],
            resources: [
                "Features/CryptoList/Resources/**"
            ],
            dependencies: [
                .target(name: "StorageKit"),
                .target(name: "NetworkKit"),
                .external(name: "ImageKit"),
                .target(name:"Favorite"),
                .external(name: "Swinject")
            ]
        ),
        .target(
            name: "Detalle",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldoVargas.Detalle",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: [
                "Features/Detalle/Sources/**"
            ],
            resources: [
                "Features/Detalle/Resources/**"
            ],
            dependencies: [
                .target(name: "StorageKit"),
                .target(name: "NetworkKit"),
                .external(name: "ImageKit"),
                .target(name: "Favorite"),
                .external(name: "Swinject")
            ]
        ),
        .target(
            name: "Favorite",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldoVargas.Favorite",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: [
                "Features/Favorite/Sources/**"
            ],
            resources: [
                "Features/Favorite/Resources/**"
            ],
            dependencies: [
                .target(name: "StorageKit"),
                .target(name: "PersistenceKit"),
                .target(name: "NetworkKit"),
                .external(name: "ImageKit"),
                .external(name: "Lottie"),
                .external(name: "Swinject")
            ]
        ),
        .target(
            name: "Configuracion",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldoVargas.Configuracion",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources:[
                "Features/Configuracion/Sources/**"
            ],
            dependencies:[
                .target(name:"StorageKit"),
                .external(name:"Swinject")
            ]
        ),
    ],
    
    schemes: [
        .scheme(
            name: "CryptoRadar",
            shared: true,
            buildAction: .buildAction(
                targets: ["CryptoRadar"]
            ),
            testAction: .targets(
                [
                    "LoginTests",
                    "RegisterTests",
                    "CryptoRadarUITests"
                ],
                options: .options(
                    coverage: true,
                    codeCoverageTargets: [
                        .target("Login"),
                        .target("Register")
                    ]
                )
            ),
            runAction: .runAction()
        )
    ]
)
