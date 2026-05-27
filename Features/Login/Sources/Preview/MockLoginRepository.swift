//
//  MockLoginRepository.swift
//  Login
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation

final class MockLoginRepository: LoginRepositoryProtocol {
    
    func login(
        email: String,
        password: String
    ) async throws -> String {
        return "mock_token_123456"
    }
}
