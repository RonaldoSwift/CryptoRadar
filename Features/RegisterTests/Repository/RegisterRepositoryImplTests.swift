//
//  RegisterRepositoryImplTests.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 17/08/26.
//

import Foundation
import Testing
@testable import Register

@Suite("RegisterRepositoryImpl")
struct RegisterRepositoryImplTests {
    
    @Test("Service success returns token")
    func serviceSuccess_returnsToken() async throws {
        let expectedToken = "response_token"
        
        let service = MockAuthServiceRegister(
            result: .success(
                RegisterResponse(
                    id: 1,
                    token: expectedToken
                )
            )
        )
        
        let repository = RegisterRepositoryImpl(
            service: service
        )
        
        let token = try await repository.register(
            email: "user@example.com",
            password: "password123"
        )
        
        #expect(token == expectedToken)
    }
    
    @Test("Service failure throws error")
    func serviceFailure_throwsError() async {
        let service = MockAuthServiceRegister(
            result: .failure(
                RegisterMockError.registerFailed
            )
        )
        
        let repository = RegisterRepositoryImpl(
            service: service
        )
        
        await #expect(throws: RegisterMockError.self) {
            _ = try await repository.register(
                email: "user@example.com",
                password: "password123"
            )
        }
    }
}
