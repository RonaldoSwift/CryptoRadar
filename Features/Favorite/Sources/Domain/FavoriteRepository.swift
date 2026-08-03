//
//  FavoriteRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 18/06/26.
//

import Foundation
import PersistenceKit

public final class FavoriteRepository: FavoriteRepositoryProtocol {

    private let database: PersistenceController

    public init(database: PersistenceController) {
        self.database = database
    }

    public func getFavorites() -> [FavoriteCrypto] {
        database.getFavorites().map { entity in
            FavoriteCrypto(
                id: entity.id,
                name: entity.name,
                symbol: entity.symbol,
                image: entity.image,
                currentPrice: 0.0
            )
        }
    }

    public func addFavorite(_ crypto: FavoriteCrypto) {
        let entity = FavoriteCryptoEntity(
            id: crypto.id,
            name: crypto.name,
            symbol: crypto.symbol,
            image: crypto.image
        )
        database.addFavorite(entity)
    }

    public func removeFavorite(id: String) {
        database.removeFavorite(id: id)
    }

    public func isFavorite(id: String) -> Bool {
        database.isFavorite(id: id)
    }
}
