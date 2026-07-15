//
//  AuthServiceLogin.swift
//  Login
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation

public protocol AuthServiceLoginProtocol {
    
    func login(
        email: String,
        password: String
    ) async throws -> LoginResponse
}

public final class AuthServiceLogin:
                                        
    AuthServiceLoginProtocol {
    
    private let apiClient = ApiClient()
    
    public init() {}
    
    public func login(email: String,password: String) async throws -> LoginResponse {
        
        let body = LoginRequest(
            email: email,
            password: password
        )
        
        return try await apiClient.request(
            endpoint: "/login",
            method: "POST",
            body: body
        )
    }
}
