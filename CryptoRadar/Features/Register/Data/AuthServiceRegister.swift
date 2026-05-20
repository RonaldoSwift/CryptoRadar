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
    
    private let baseURL = "https://reqres.in/api/register"
    private let apiKey = "reqres_301f6522479440dda463c442030bb5fa"
    
    func register(
        email: String,
        password: String
    ) async throws -> RegisterResponse {
        
        guard let url = URL(string: baseURL) else {
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
        
        guard let httpResponse = response as? HTTPURLResponse
        else {
            throw URLError(.badServerResponse)
        }
        
        print("Status:", httpResponse.statusCode)
        
        if let responseString = String(
            data: data,
            encoding: .utf8
        ) {
            print("Response:", responseString)
        }
        
        if !(200...299).contains(
            httpResponse.statusCode
        ) {
            
            throw NSError(
                domain: "",
                code: httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey:
                    "Error del servidor: \(httpResponse.statusCode)"
                ]
            )
        }
        
        return try JSONDecoder().decode(
            RegisterResponse.self,
            from: data
        )
    }
}

