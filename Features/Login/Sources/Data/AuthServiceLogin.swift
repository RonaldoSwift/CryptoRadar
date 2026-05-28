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

public final class AuthServiceLogin: AuthServiceLoginProtocol {
    
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
    
    public init() {}
    
    public func login(
        email: String,
        password: String
    ) async throws -> LoginResponse {
        
        guard let url = URL(
            string: "\(baseURL)/login"
        ) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(
            url: url
        )
        
        request.httpMethod = "POST"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.setValue(
            apiKey,
            forHTTPHeaderField: "x-api-key"
        )
        
        let body = LoginRequest(
            email: email,
            password: password
        )
        
        request.httpBody = try JSONEncoder()
            .encode(body)
        
        let (data,response) = try await URLSession
            .shared
            .data(for: request)
        
        guard let httpResponse =
                response as? HTTPURLResponse
        else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(
            httpResponse.statusCode
        )
        else {
            
            throw NSError(
                domain: "",
                code: httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey:
                    "Error del servidor: \(httpResponse.statusCode)"
                ]
            )
        }
        
        return try JSONDecoder()
            .decode(
                LoginResponse.self,
                from: data
            )
    }
}
