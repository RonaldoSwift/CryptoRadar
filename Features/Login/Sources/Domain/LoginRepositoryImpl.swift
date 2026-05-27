//
//  LoginRepositoryImpl.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation

public final class LoginRepositoryImpl: LoginRepositoryProtocol {
    
    private let service: AuthServiceLoginProtocol
    
    public init(service: AuthServiceLoginProtocol) {
        self.service = service
    }
    
    public func login(email: String, password: String) async throws -> String {
        let response =
        try await service.login(
            email: email,
            password: password
        )
        return response.token
    }
}
