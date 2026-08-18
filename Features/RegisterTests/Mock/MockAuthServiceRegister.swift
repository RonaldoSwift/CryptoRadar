//
//  MockAuthServiceRegister.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 17/08/26.
//

import Foundation
@testable import Register

final class MockAuthServiceRegister: AuthServiceRegisterProtocol {
    
    var result: Result<RegisterResponse, Error>
    
    init(result: Result<RegisterResponse, Error>) {
        self.result = result
    }
    
    func register(
        email: String,
        password: String
    ) async throws -> RegisterResponse {
        try result.get()
    }
}
