//
//  MockCryptoDetailRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 9/06/26.
//

import Foundation

final class MockCryptoDetailRepository: CryptoDetailRepositoryProtocol {
    
    func getCryptoDetail(id: String) async throws -> CryptoDetail {
        CryptoDetail(
            id: "bitcoin",
            name: "Bitcoin",
            image: "",
            description:
                "advaDv",
            currentPrice: 105432.20,
            isFavorite: false
        )
    }
}
