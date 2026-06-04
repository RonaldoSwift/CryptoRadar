//
//  CryptoListAssembly.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation
import Swinject

public final class CryptoListAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(CryptoServiceProtocol.self) { _ in
            AuthServiceCryptoList()
        }
        
        container.register(CryptoListRepositoryProtocol.self) { resolver in
            CryptoListRepositoryImpl(
                service:resolver.resolve(CryptoServiceProtocol.self)!
            )
        }
        
        container.register(CryptoListViewModel.self) { resolver in
            CryptoListViewModel(repository:resolver.resolve(CryptoListRepositoryProtocol.self)!
            )
        }
    }
}
