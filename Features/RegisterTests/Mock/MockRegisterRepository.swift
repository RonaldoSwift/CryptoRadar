//
//  MockRegisterRepository.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 17/08/26.
//

import Foundation
import Register

final class MockRegisterRepository: RegisterRepositoryProtocol {
    
    var result: Result<String, Error>
    
    init(result: Result<String, Error>) {
        self.result = result
    }
    
    func register(
        email: String,
        password: String
    ) async throws -> String {
        try result.get()
    }
}
