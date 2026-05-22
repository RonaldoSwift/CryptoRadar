//
//  RegisterRepositoryImpl.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/05/26.
//

import Foundation

final class RegisterRepositoryImpl: RegisterRepositoryProtocol {
    
    private let service: AuthServiceRegisterProtocol
    
    init(service: AuthServiceRegisterProtocol) {
        self.service = service
    }
    
    func register(
        email: String,
        password: String
    ) async throws -> String {
        
        let response = try await service.register(
            email: email,
            password: password
        )
        
        return response.token
    }
}
