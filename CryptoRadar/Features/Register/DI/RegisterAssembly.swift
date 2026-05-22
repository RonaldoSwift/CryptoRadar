//
//  RegisterAssembly.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/05/26.
//

import Foundation
import Swinject

final class RegisterAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(
            AuthServiceRegisterProtocol.self
        ) { _ in
            AuthServiceRegister()
        }
        
        container.register(
            RegisterRepositoryProtocol.self
        ) { resolver in
            RegisterRepositoryImpl(
                service: resolver.resolve(
                    AuthServiceRegisterProtocol.self
                )!
            )
        }
        
        container.register(
            RegisterViewModel.self
        ) { resolver in
            RegisterViewModel(
                repository: resolver.resolve(
                    RegisterRepositoryProtocol.self
                )!
            )
        }
    }
}
