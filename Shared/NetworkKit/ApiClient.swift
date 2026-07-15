//
//  ApiClient.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/07/26.
//

import Foundation

public final class ApiClient {
    
    private let baseURL: String
    private let apiKey: String
    
    public init() {
        self.baseURL =
        Bundle.main.object(
            forInfoDictionaryKey: "BASE_URL"
        ) as? String ?? ""
        
        self.apiKey =
        Bundle.main.object(
            forInfoDictionaryKey: "REQRES_API_KEY"
        ) as? String ?? ""
    }
    
    public func request<Response: Decodable, Body: Encodable>(
        endpoint: String,
        method: String = "GET",
        body: Body? = nil
    ) async throws -> Response {
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.setValue(
            apiKey,
            forHTTPHeaderField: "x-api-key"
        )
        
        if let body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        let (data, response) =
        try await URLSession.shared.data(for: request)
        
        guard let http =
                response as? HTTPURLResponse
        else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(http.statusCode)
        else {
            
            throw NSError(
                domain: "",
                code: http.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Error del servidor \(http.statusCode)"
                ]
            )
        }
        
        return try JSONDecoder()
            .decode(
                Response.self,
                from: data
            )
    }
}
