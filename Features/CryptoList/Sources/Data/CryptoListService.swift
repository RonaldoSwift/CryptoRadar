//
//  AuthServiceCryptoList.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation

public protocol CryptoListServiceProtocol {
    func getTopCryptos() async throws -> [CryptoResponse]
    func searchCryptos(query: String) async throws -> SearchResponse

}

public final class CryptoListService: CryptoListServiceProtocol {
    
    private var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "BASE_URL_LIST_CRYPTO") as? String ?? ""
    }
    
    public init() {}
    
    public func getTopCryptos() async throws -> [CryptoResponse] {
        
        guard let url = URL(string:"\(baseURL)/coins/markets?vs_currency=usd&per_page=20&page=1")
        else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json",forHTTPHeaderField:"Content-Type")
        
        let (data, response) = try await URLSession
            .shared
            .data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse
                
        else {
            throw URLError(
                .badServerResponse
            )
        }
        
        guard (200...299)
            .contains(httpResponse.statusCode)
                
        else {
            throw NSError(
                domain: "",
                code:httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey: "Error del servidor: \(httpResponse.statusCode)"
                ]
            )
        }
        
        return try JSONDecoder()
            .decode(
                [CryptoResponse].self,
                from: data
            )
    }
    
    public func searchCryptos(query: String) async throws -> SearchResponse {

        var components = URLComponents(string: "\(baseURL)/search")!

        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(
            SearchResponse.self,
            from: data
        )
    }
}
