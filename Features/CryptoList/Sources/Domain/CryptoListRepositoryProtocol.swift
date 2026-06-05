//
//  CryptoRepositoryProtocol.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation

public protocol CryptoListRepositoryProtocol {
    
    func getTopCryptos() async throws -> [Crypto]
}
