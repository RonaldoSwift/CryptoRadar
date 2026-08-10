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

    public init(database:PersistenceController) {
        self.database = database
    }

    public func getFavorites() -> [FavoriteCrypto] {
        database.getFavorites().map { $0.toDomain() }
    }

    public func addFavorite(_ crypto: FavoriteCrypto) {
        database.addFavorite(crypto.toEntity())
    }

    public func removeFavorite(id:String) {
        database.removeFavorite(id: id)
    }

    public func isFavorite(id:String) -> Bool {
        database.isFavorite(id: id)
    }
}

// MARK: - Mappers

private extension FavoriteCryptoEntity {

    func toDomain() -> FavoriteCrypto {
        FavoriteCrypto(
            id: id,
            name: name,
            symbol: symbol,
            image: image,
            currentPrice: 0.0
        )
    }
}

private extension FavoriteCrypto {

    func toEntity() -> FavoriteCryptoEntity {
        FavoriteCryptoEntity(
            id: id,
            name: name,
            symbol: symbol,
            image: image
        )
    }
}
