//
//  MockAuthService.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 17/08/26.
//

import Foundation
@testable import Login

enum LoginMockError: LocalizedError {
    case loginFailed

    var errorDescription: String? {
        "Login Failed"
    }
}

final class MockAuthService: AuthServiceLoginProtocol {

    var result: Result<LoginResponse, Error>

    init(result: Result<LoginResponse, Error>) {
        self.result = result
    }

    func login(
        email: String,
        password: String
    ) async throws -> LoginResponse {
        try result.get()
    }
}
