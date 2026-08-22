//
//  MockLoginRepository.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 17/08/26.
//

import Foundation

@testable import Login
final class MockLoginRepository: LoginRepositoryProtocol {

    var result: Result<String, Error>

    init(result: Result<String, Error>) {
        self.result = result
    }

    func login(
        email: String,
        password: String
    ) async throws -> String {
        try result.get()
    }
}
