//
//  DetalleService.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 5/06/26.
//

import Foundation

public final class DetalleService {
    
    private var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey:"BASE_URL_LIST_CRYPTO") as? String ?? ""
    }
    
    public init() {}
    
    public func getCryptoDetail(id: String) async throws -> CryptoDetailResponse {
        
        guard let url = URL(string:"\(baseURL)/coins/\(id)")
        else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.setValue("application/json",forHTTPHeaderField:"Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse
        else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode)
                
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
                CryptoDetailResponse.self,
                from: data
            )
    }
}
