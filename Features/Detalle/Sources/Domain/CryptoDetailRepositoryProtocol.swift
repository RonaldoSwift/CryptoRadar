//
//  CryptoDetailRepositoryProtocol.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 8/06/26.
//

import Foundation

public protocol CryptoDetailRepositoryProtocol {
    func getCryptoDetail(id: String) async throws -> CryptoDetail
}
