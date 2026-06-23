//
//  FavoriteCrypto.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/06/26.
//

import Foundation

public struct FavoriteCrypto: Identifiable {

    public let id: String
    public let name: String
    public let symbol: String
    public let image: String
    public let currentPrice: Double

    public init(
        id: String,
        name: String,
        symbol: String,
        image: String,
        currentPrice: Double
    ) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.image = image
        self.currentPrice = currentPrice
    }
}
