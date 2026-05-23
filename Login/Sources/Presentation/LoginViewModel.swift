//
//  LoginViewModel.swift
//  Login
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation
import Combine

@MainActor
public final class LoginViewModel:
                                        
    ObservableObject {
    
    @Published public var email = ""
    @Published public var password = ""
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    @Published public var token = ""
    
    private let repository:
    LoginRepositoryProtocol
    
    public init(
        repository: LoginRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    public func login() {
        errorMessage = nil
        guard !email.isEmpty else {
            errorMessage =
            String(
                localized:
                    "Login.Error.EmptyEmail"
            )
            return
        }
        
        guard !password.isEmpty else {
            
            errorMessage =
            String(
                localized:
                    "Login.Error.EmptyPassword"
            )
            return
        }
        isLoading = true
        Task {
            do {
                let responseToken =
                try await repository.login(
                    email: email,
                    password: password
                )
                token = responseToken
            } catch {
                errorMessage =
                error.localizedDescription
            }
            isLoading = false
        }
    }
}
