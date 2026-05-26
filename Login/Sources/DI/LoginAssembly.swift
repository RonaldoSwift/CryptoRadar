//
//  LoginAssembly.swift
//  Login
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation
import Swinject

public final class LoginAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(
            AuthServiceLoginProtocol.self
        ) { _ in
            AuthServiceLogin()
        }
        
        container.register(LoginRepositoryProtocol.self) { resolver in
            LoginRepositoryImpl(
                service:
                    resolver.resolve(
                        AuthServiceLoginProtocol.self
                    )!
            )
        }
        
        container.register(LoginViewModel.self) { @MainActor resolver in
            LoginViewModel(
                repository:
                    resolver.resolve(
                        LoginRepositoryProtocol.self
                    )!
            )
        }
    }
}
