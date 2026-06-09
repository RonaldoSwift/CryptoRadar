//
//  CryptoDetailRepositoryImpl.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 8/06/26.
//

import Foundation

public final class CryptoDetailRepositoryImpl: CryptoDetailRepositoryProtocol {
    
    private let service: DetalleServiceProtocol
    
    public init(service: DetalleServiceProtocol) {
        self.service = service
    }
    
    public func getCryptoDetail(id: String) async throws -> CryptoDetail {
        
        let response = try await service.getCryptoDetail(id: id)
        
        return CryptoDetail(
            id:response.id,
            name:response.name,
            image:response.image.large,
            description:response.description.en,
            currentPrice:response.marketData.currentPrice["usd"] ?? 0,
            isFavorite:false
        )
    }
}
