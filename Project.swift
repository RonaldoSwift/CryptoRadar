import ProjectDescription

let project = Project(
    name: "CryptoRadar",
    
    targets: [
        .target(
            name: "CryptoRadar",
            destinations: .iOS,
            product: .app,
            bundleId: "com.ronaldoVargas.CryptoRadar",
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
                .target(name: "ImageKit"),
                .target(name: "PersistenceKit"),
                .external(name:"Swinject")
            ]
        ),
        
            .target(
                name: "StorageKit",
                destinations: .iOS,
                product: .framework,
                bundleId: "com.ronaldoVargas.StorageKit",
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
                infoPlist: .default,
                sources: [
                    "Shared/NetworkKit/**"
                ]
            ),
        
            .target(
                name: "ImageKit",
                destinations: .iOS,
                product: .framework,
                bundleId: "com.ronaldoVargas.ImageKit",
                infoPlist: .default,
                sources: [
                    "Shared/ImageKit/**"
                ]
            ),
        
        
        // FEATURES
        
            .target(
                name: "Login",
                destinations: .iOS,
                product: .framework,
                bundleId: "com.ronaldoVargas.Login",
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
            name: "CryptoList",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldoVargas.CryptoList",
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
                .target(name: "ImageKit"),
                .target(name:"Favorite"),
                .external(name: "Swinject")
            ]
        ),
        .target(
            name: "Detalle",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldoVargas.Detalle",
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
                .target(name: "ImageKit"),
                .target(name: "Favorite"),
                .external(name: "Swinject")
            ]
        ),
        .target(
            name: "Favorite",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldoVargas.Favorite",
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
                .target(name: "ImageKit"),
                .external(name: "Swinject")
            ]
        ),
        .target(
            name: "Configuracion",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldoVargas.Configuracion",
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
            testAction: .targets(["LoginTests"]),
            runAction: .runAction()
        )
    ]
)
