//
//  CryptoRepositoryImpl.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation

public final class CryptoListRepositoryImpl: CryptoListRepositoryProtocol {
    
    private let service: CryptoListServiceProtocol
    
    public init(service:CryptoListServiceProtocol) {
        self.service = service
    }
    
    public func getTopCryptos() async throws -> [Crypto] {
        let response = try await service.getTopCryptos()
        return response.map { cryptoResponse in
            Crypto(
                id: cryptoResponse.id,
                symbol: cryptoResponse.symbol,
                name: cryptoResponse.name,
                image: cryptoResponse.image
            )
        }
    }
    
    public func searchCryptos(query: String) async throws -> [Crypto] {
        
        let response = try await service.searchCryptos(query: query)
        return response.coins.map { crypto in
            Crypto(
                id: crypto.id,
                symbol: crypto.symbol,
                name: crypto.name,
                image: crypto.thumb
            )
        }
    }
}
