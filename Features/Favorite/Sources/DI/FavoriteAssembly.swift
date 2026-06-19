//
//  FavoriteAssembly.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 16/06/26.
//


//
//  FavoriteAssembly.swift
//

import Foundation
import Swinject

@MainActor
public final class FavoriteAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {

        container.register(CryptoRadarDB.self) { _ in
            CryptoRadarDB()
        }

        container.register(FavoriteRepositoryProtocol.self) { resolver in
            FavoriteRepository(database:resolver.resolve(CryptoRadarDB.self)!)
        }

        container.register(FavoriteListViewModel.self) {@MainActor resolver in
            FavoriteListViewModel(repository:resolver.resolve(FavoriteRepositoryProtocol.self)!
            )
        }
    }
}
