//
//  FavoriteCryptoEntity.swift
//  Favorite
//
//  Created by Ronaldo Andre on 18/06/26.
//

import Foundation
import SwiftData

@Model
public final class FavoriteCryptoEntity {

    @Attribute(.unique) public var id: String

    public var name: String
    public var symbol: String
    public var image: String

    public init(
        id: String,
        name: String,
        symbol: String,
        image: String,
    ) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.image = image
    }
}
