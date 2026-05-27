//
//  RegisterAssembly.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 26/05/26.
//

import Foundation
import Swinject

public final class RegisterAssembly: Assembly {

    public init() {}
    
    public func assemble(container: Container) {
        
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
        ) { @MainActor resolver in
            RegisterViewModel(
                repository: resolver.resolve(
                    RegisterRepositoryProtocol.self
                )!
            )
        }
    }
}
