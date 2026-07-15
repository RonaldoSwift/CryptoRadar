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
                image: cryptoResponse.image,
                currentPrice: cryptoResponse.currentPrice,
                priceChangePercentage24h: cryptoResponse.priceChangePercentage24h
            )
        }
    }
    
    public func searchCryptos(query: String) async throws -> [Crypto] {

        let response = try await service.searchCryptos(query: query)
        return response.coins.map {
            Crypto(
                id: $0.id,
                symbol: $0.symbol,
                name: $0.name,
                image: $0.thumb,
                currentPrice: 0,
                priceChangePercentage24h: 0
            )
        }
    }
}
