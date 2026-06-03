//
//  RegisterViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 26/05/26.
//

import Foundation
import Combine

@MainActor
public final class RegisterViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var token = ""
    private let repository: RegisterRepositoryProtocol
    
    public init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }
    
    func register() {
        
        guard !name.isEmpty else {
            errorMessage = String(
                localized: "Register.Error.EmptyName"
            )
            return
        }
        
        guard !email.isEmpty else {
            errorMessage = String(
                localized: "Register.Error.EmptyEmail"
            )
            return
        }
        
        guard email.isValidEmail else {
            errorMessage = String(
                localized: "Register.Error.InvalidEmail"
            )
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = String(
                localized: "Register.Error.EmptyPassword"
            )
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = String(
                localized: "Register.Error.PasswordMinLength"
            )
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = String(
                localized: "Register.Error.PasswordMismatch"
            )
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let responseToken =
                try await repository.register(
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

// MARK: - String Extensions

public extension String {
    
    var isValidEmail: Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        
        return NSPredicate(
            format: "SELF MATCHES %@",
            emailRegex)
        .evaluate(with: self)
    }
}

