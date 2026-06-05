//
//  Crypto.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 5/06/26.
//

import Foundation

public struct Crypto: Identifiable {

    public let id: String
    public let symbol: String
    public let name: String
    public let image: String
    public let currentPrice: Double
    public let priceChangePercentage24h: Double
}
