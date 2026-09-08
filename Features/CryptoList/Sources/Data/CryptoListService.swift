//
//  AuthServiceCryptoList.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation
import NetworkKit

public protocol CryptoListServiceProtocol {
    func getTopCryptos() async throws -> [CryptoResponse]
    func searchCryptos(query: String) async throws -> SearchResponse

}

public final class CryptoListService: CryptoListServiceProtocol {
    private let apiClient = ApiClient()
    private var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "BASE_URL_LIST_CRYPTO") as? String ?? ""
    }
    
    public init() {}
    
    public func getTopCryptos() async throws -> [CryptoResponse] {
        for attempt in 0..<3 {
            do {
                return try await apiClient.request(
                    baseURL: baseURL,
                    endpoint: "/coins/markets",
                    queryItems: [
                        URLQueryItem(name: "vs_currency", value: "usd"),
                        URLQueryItem(name: "per_page", value: "20"),
                        URLQueryItem(name: "page", value: "1")
                    ]
                )
            } catch {
                guard attempt < 2 else { throw error }
                try? await Task.sleep(for: .seconds(1))
            }
        }

        throw URLError(.cannotLoadFromNetwork)
    }
    
    public func searchCryptos(
        query: String
    ) async throws -> SearchResponse {
        try await apiClient.request(
            baseURL: baseURL,
            endpoint: "/search",
            queryItems: [
                URLQueryItem(name: "query", value: query)
            ]
        )
    }
}
