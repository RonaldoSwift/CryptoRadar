//
//  FavoriteCrypto.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/06/26.
//

import Foundation
import SwiftData

@Model
public final class FavoriteCrypto {

    @Attribute(.unique)
    public var id: String

    public var name: String
    public var symbol: String
    public var image: String
    public var currentPrice: Double

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
