import ProjectDescription

let project = Project(
    name: "CryptoRadar",
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.0"))
    ],

    settings: .settings(
    configurations: [
        .debug(
            name: "Debug",
            xcconfig: .relativeToRoot("Configs/Debug.xcconfig")
            ),
        .release(
            name: "Release",
            xcconfig: .relativeToRoot("Configs/Release.xcconfig")
            )
        ]
    ),

    targets: [
        .target(
            name: "CryptoRadar",
            destinations: .iOS,
            product: .app,
            bundleId: "com.ronaldo.CryptoRadar",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": ""
                    ],
                    "BASE_URL": "$(BASE_URL)",
                    "ENVIRONMENT": "$(ENVIRONMENT)"
                ]
            ),
            buildableFolders: [
                "CryptoRadar/Sources",
                "CryptoRadar/Resources"
            ],
            dependencies: [
                .target(name: "Login"),
                .target(name: "Register"),
                .target(name: "CryptoList"),
                .target(name: "Detalle"),
                .target(name: "Favorite"),
                .target(name: "Configuracion")

            ]
        ),

        .target(
            name: "StorageKit",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.StorageKit",
            infoPlist: .default,
            buildableFolders: [
                "Shared/StorageKit",
            ],
            dependencies: [
            ]
        ),

        .target(
            name: "PersistenceKit",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.PersistenceKit",
            infoPlist: .default,
            buildableFolders: [
                "Shared/PersistenceKit"
            ],
            dependencies: [
            ]
        ),

        .target(
            name: "NetworkKit",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.NetworkKit",
            infoPlist: .default,
            buildableFolders: [
                "Shared/NetworkKit"
            ],
            dependencies: [
            ]
        ),

        .target(
            name: "ImageKit",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.ImageKit",
            infoPlist: .default,
            buildableFolders: [
                "Shared/ImageKit"
            ],
            dependencies: [
            ]
        ),

        .target(
            name: "Login",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.Login",
            infoPlist: .default,
            buildableFolders: [
                "Features/Login/Sources",
                "Features/Login/Resources"
            ],
            dependencies: [
                .target(name: "StorageKit"),
            ]
        ),

        .target(
            name: "Register",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.Register",
            infoPlist: .default,
            buildableFolders: [
                "Features/Register/Sources",
                "Features/Register/Resources"
            ],
            dependencies: [
                .target(name: "StorageKit")
            ]
        ),

        .target(
            name: "CryptoList",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.CryptoList",
            infoPlist: .default,
            buildableFolders: [
                "Features/CryptoList/Sources",
                "Features/CryptoList/Resources"
            ],
            dependencies: [
                .target(name: "NetworkKit"),
                .target(name: "ImageKit"),
                .target(name: "Favorite")
            ]
        ),

        .target(
            name: "Detalle",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.Detalle",
            infoPlist: .default,
            buildableFolders: [
                "Features/Detalle/Sources",
                "Features/Detalle/Resources"
            ],
            dependencies: [
                .target(name: "NetworkKit"),
                .target(name: "ImageKit"),
                .target(name: "StorageKit"),
                .target(name: "Favorite")
            ]
        ),

        .target(
            name: "Favorite",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.Favorite",
            infoPlist: .default,
            buildableFolders: [
                "Features/Favorite/Sources",
                "Features/Favorite/Resources"
            ],
            dependencies: [
                .target(name: "StorageKit"),
                .target(name: "PersistenceKit"),
                .package(product: "Swinject")
            ]
        ),

        .target(
            name: "Configuracion",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.Configuracion",
            infoPlist: .default,
            buildableFolders: [
                "Features/Configuracion/Sources"
            ],
            dependencies: [
                .target(name: "StorageKit")
            ]
        ),

        //Tests

        .target(
            name: "LoginTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.ronaldo.LoginTests",
            infoPlist: .default,
            buildableFolders: [
                "Features/LoginTests"
            ],
            dependencies: [
                .target(name: "Login")
            ]
        ),

        .target(
            name: "RegisterTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.ronaldo.RegisterTests",
            infoPlist: .default,
            buildableFolders: [
                "Features/RegisterTests"
            ],
            dependencies: [
                .target(name: "Register")
            ]
        ),

        .target(
            name: "CryptoListTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.ronaldo.CryptoListTests",
            infoPlist: .default,
            buildableFolders: [
                "Features/CryptoListTests"
            ],
            dependencies: [
                .target(name: "CryptoList")
            ]
        ),

        .target(
            name: "DetalleTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.ronaldo.DetalleTests",
            infoPlist: .default,
            buildableFolders: [
                "Features/DetalleTests"
            ],
            dependencies: [
                .target(name: "Detalle")
            ]
        ),

        .target(
            name: "FavoriteTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.ronaldo.FavoriteTests",
            infoPlist: .default,
            buildableFolders: [
                "Features/FavoriteTests"
            ],
            dependencies: [
                .target(name: "Favorite")
            ]
        ),

        .target(
            name: "ConfiguracionTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.ronaldo.ConfiguracionTests",
            infoPlist: .default,
            buildableFolders: [
                "Features/ConfiguracionTests"
            ],
            dependencies: [
                .target(name: "Configuracion")
            ]
        ),

        .target(
            name: "StorageKitTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.ronaldo.StorageKitTests",
            infoPlist: .default,
            buildableFolders: [
                "Shared/StorageKitTests"
            ],
            dependencies: [
                .target(name: "StorageKit")
            ]
        ),

        .target(
            name: "CryptoRadarTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.ronaldo.CryptoRadarTests",
            infoPlist: .default,
            buildableFolders: [
                "CryptoRadarTests"
            ],
            dependencies: [
                .target(name: "CryptoRadar")
            ]
        ),

        .target(
            name: "CryptoRadarUITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "com.ronaldo.CryptoRadarUITests",
            infoPlist: .default,
            buildableFolders: [
                "CryptoRadarUITests"
            ],
            dependencies: [
                .target(name: "CryptoRadar")
            ]
        ),

        .target(
            name: "DIKit",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.ronaldo.DIKit",
            infoPlist: .default,
            buildableFolders: [
                "Shared/DIKit"
            ],
            dependencies:[
                .target(name:"Login"),
                .target(name:"Register"),
                .target(name:"CryptoList"),
                .target(name:"Detalle"),
                .target(name:"Favorite"),
                .target(name:"Configuracion"),
                .target(name:"NetworkKit"),
                .target(name:"StorageKit"),
                .package(product:"Swinject")
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
        runAction: .runAction()
    )
]
)
