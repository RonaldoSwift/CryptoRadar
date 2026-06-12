//
//  DetalleAssembly.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 9/06/26.
//

import Foundation
import Swinject

public final class DetalleAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(CryptoDetailService.self.self) { _ in
            CryptoDetailService()
        }
        
        container.register(CryptoDetailRepositoryProtocol.self) { resolver in
            CryptoDetailRepositoryImpl(
                service: resolver.resolve(CryptoDetailService.self)!
            )
        }
        
        container.register(CryptoDetailViewModel.self) { @MainActor resolver in
            CryptoDetailViewModel(
                repository: resolver.resolve(CryptoDetailRepositoryProtocol.self)!
            )
        }
    }
}
