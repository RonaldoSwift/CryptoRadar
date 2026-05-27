//
//  MockRegisterRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 26/05/26.
//

import Foundation

final class MockRegisterRepository:
    RegisterRepositoryProtocol {
    
    func register(
        email: String,
        password: String
    ) async throws -> String {
        return "mock_token"
    }
}
