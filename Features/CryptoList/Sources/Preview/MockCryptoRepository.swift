//
//  MockCryptoRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation

final class MockCryptoRepository: CryptoListRepositoryProtocol {
    
    func getTopCryptos() async throws -> [CryptoResponse] {
        [
            CryptoResponse(
                id: "bitcoin",
                symbol: "BTC",
                name: "Bitcoin",
                image: "",
                currentPrice: 64321.50,
                priceChangePercentage24h: 2.45
            ),
            
            CryptoResponse(
                id: "ethereum",
                symbol: "ETH",
                name: "Ethereum",
                image: "",
                currentPrice: 3452.12,
                priceChangePercentage24h: -1.12
            )
        ]
    }
}
