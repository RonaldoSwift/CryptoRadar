//
//  LoginViewModel.swift
//  Login
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation
import Combine
import StorageKit
import NetworkKit

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
    
    private func message(for error: Error, fallback: String) -> String {
        NetworkError.message(for: error, fallback: fallback)
    }

    public func login() async {
        errorMessage = nil
        guard !email.isEmpty else {
            errorMessage = LoginStrings.Login.Error.emptyEmail
            return
        }
        
        guard email.isValidEmail else {
            errorMessage = LoginStrings.Login.Error.invalidEmail
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = LoginStrings.Login.Error.emptyPassword
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = LoginStrings.Login.Error.passwordMinLength
            return
        }
        
        isLoading = true
        
        do {
            let responseToken = try await repository.login(
                email: email,
                password: password
            )
            token = responseToken
            showSuccessAlert = true
        } catch {
            errorMessage = message(
                for: error,
                fallback: LoginStrings.Login.Error.loginFailed
            )
        }
        isLoading = false
    }
}
