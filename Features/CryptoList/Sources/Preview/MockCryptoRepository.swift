//
//  MockCryptoRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation

final class MockCryptoRepository: CryptoListRepositoryProtocol {
    
    func searchCryptos(query: String) async throws -> [Crypto] {
        let cryptos = try await getTopCryptos()
        return cryptos.filter {
            $0.name.localizedCaseInsensitiveContains(query) ||
            $0.symbol.localizedCaseInsensitiveContains(query)
        }
    }
    
    
    func getTopCryptos() async throws -> [Crypto] {
        [
            Crypto(
                id: "bitcoin",
                symbol: "BTC",
                name: "Bitcoin",
                image: "",
                currentPrice: 64321.50,
                priceChangePercentage24h: 2.45
            ),
            
            Crypto(
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
