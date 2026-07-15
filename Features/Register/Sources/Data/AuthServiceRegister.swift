//
//  AuthServiceRegister.swift
//  Register
//
//  Created by Ronaldo Andre on 26/05/26.
//

import Foundation

protocol AuthServiceRegisterProtocol {
    func register(email: String,password: String) async throws -> RegisterResponse
}

final class AuthServiceRegister: AuthServiceRegisterProtocol {

    private let apiClient = ApiClient()

    func register(email: String,password: String) async throws -> RegisterResponse {

        let body = RegisterRequest(
            email: email,
            password: password
        )

        return try await apiClient.request(
            endpoint: "/register",
            method: "POST",
            body: body
        )
    }
}
