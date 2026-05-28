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
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var token = ""
    private let repository: RegisterRepositoryProtocol
    
    public init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }
    
    func register() {
        
        guard !email.isEmpty else {
            errorMessage = "Se requiere un email"
            return
        }
        
        guard !email.contains("@") else {
            errorMessage = "Email invalido @"
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Se requiere una contraseña"
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "Contraseña debe tener minimo 6 caracteres"
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Las contraseñas no coinciden"
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
