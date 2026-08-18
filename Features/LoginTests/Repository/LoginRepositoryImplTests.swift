//
//  LoginRepositoryImplTests.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 17/08/26.
//

import Foundation
import Testing
@testable import Login

@Suite("LoginRepositoryImpl")
struct LoginRepositoryImplTests {

    @Test("Service success returns token")
    func serviceSuccess_returnsToken() async throws {
        let expectedToken = "response_token"

        let service = MockAuthService(
            result: .success(
                LoginResponse(token: expectedToken)
            )
        )

        let repository = LoginRepositoryImpl(
            service: service
        )

        let token = try await repository.login(
            email: "user@example.com",
            password: "password123"
        )

        #expect(token == expectedToken)
    }

    @Test("Service failure throws error")
    func serviceFailure_throwsError() async {
        let service = MockAuthService(
            result: .failure(LoginMockError.loginFailed)
        )

        let repository = LoginRepositoryImpl(
            service: service
        )

        await #expect(throws: LoginMockError.self) {
            _ = try await repository.login(
                email: "user@example.com",
                password: "password123"
            )
        }
    }
}
