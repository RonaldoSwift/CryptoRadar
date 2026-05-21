//
//  MockRegisterRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 21/05/26.
//

import Foundation

final class MockRegisterRepository:
    RegisterRepository {
    
    func register(
        email: String,
        password: String
    ) async throws -> String {
        return "mock_token"
    }
}
