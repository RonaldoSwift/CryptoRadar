//
//  LoginViewModel.swift
//  Login
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation
import Combine

@MainActor
public final class LoginViewModel: ObservableObject {
    
    @Published public var email = ""
    @Published public var password = ""
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    @Published public var token = ""
    @Published var showSuccessAlert = false
    
    private let repository: LoginRepositoryProtocol
    
    public init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }
    
    public func login() {
        errorMessage = nil
        guard !email.isEmpty else {
            errorMessage = LoginStrings.Login.emptyEmail
            return
        }
        
        guard email.isValidEmail else {
            errorMessage = LoginStrings.Login.invalidEmail
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = LoginStrings.Login.emptyPassword
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = LoginStrings.Login.passwordMinLength
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let responseToken = try await repository.login(
                    email: email,
                    password: password
                )
                token = responseToken
                showSuccessAlert = true
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
