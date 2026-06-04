//
//  CryptoRepositoryImpl.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation

public final class CryptoListRepositoryImpl:
                                            
    CryptoListRepositoryProtocol {
    
    private let service:CryptoServiceProtocol
    
    public init(service: CryptoServiceProtocol)
    {
        self.service = service
    }
    
    public func getTopCryptos() async throws -> [CryptoResponse] {
        try await service.getTopCryptos()
    }
}
