//
//  DetalleAssembly.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 9/06/26.
//

import Foundation
import Swinject
import Favorite

public final class DetalleAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(DetalleService.self) { _ in
            DetalleService()
        }
        
        container.register(CryptoDetailRepositoryProtocol.self) { resolver in
            CryptoDetailRepositoryImpl(
                service: resolver.resolve(DetalleService.self)!
            )
        }
        
        container.register(CryptoDetailViewModel.self) { @MainActor resolver in
            CryptoDetailViewModel(
                repository: resolver.resolve(CryptoDetailRepositoryProtocol.self)!,
                favoriteRepository: resolver.resolve(FavoriteRepositoryProtocol.self)!
            )
        }
    }
}
