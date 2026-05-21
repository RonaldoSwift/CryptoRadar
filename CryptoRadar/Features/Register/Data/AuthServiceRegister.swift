//
//  AuthServiceRegister.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/05/26.
//

import Foundation

protocol AuthServiceRegisterProtocol {
    
    func register(
        email: String,
        password: String
    ) async throws -> RegisterResponse
}

final class AuthServiceRegister: AuthServiceRegisterProtocol {
    
    private var baseURL: String {
        Bundle.main.object(
            forInfoDictionaryKey: "BASE_URL"
        ) as? String ?? ""
    }
    
    private var apiKey: String {
        Bundle.main.object(
            forInfoDictionaryKey: "REQRES_API_KEY"
        ) as? String ?? ""
    }
    
    func register(
        email: String,
        password: String
    ) async throws -> RegisterResponse {
        
        guard let url = URL(
            string: "\(baseURL)/register"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        request.setValue(
            apiKey,
            forHTTPHeaderField: "x-api-key"
        )

        let body = RegisterRequest(
            email: email,
            password: password
        )

        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(
            for: request
        )

        guard let httpResponse =
                response as? HTTPURLResponse
        else {
            throw URLError(.badServerResponse)
        }

        guard
            200...299 ~= httpResponse.statusCode
        else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(
            RegisterResponse.self,
            from: data
        )
    }
}
