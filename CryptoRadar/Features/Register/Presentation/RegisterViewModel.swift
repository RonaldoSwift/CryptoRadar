//
//  RegisterViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/05/26.
//

import Foundation
import Combine

@MainActor
final class RegisterViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var token = ""
    private let repository: RegisterRepository
    
    init(repository: RegisterRepository) {
        self.repository = repository
    }
    
    func register() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let responseToken = try await repository.register(
                    email: email,
                    password: password
                )
                token = responseToken
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
