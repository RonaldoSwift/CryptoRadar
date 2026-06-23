//
//  FavoriteRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 18/06/26.
//

import Foundation

public final class FavoriteRepository: FavoriteRepositoryProtocol {

    private let database: PersistenceController

    public init(database:PersistenceController) {
        self.database = database
    }

    public func getFavorites() -> [FavoriteCrypto] {
        database.getFavorites()
    }

    public func addFavorite(_ crypto:FavoriteCrypto) {
        database.addFavorite(crypto)
    }

    public func removeFavorite(id:String) {
        database.removeFavorite(id: id)
    }

    public func isFavorite(id:String) -> Bool {
        database.isFavorite(id: id)
    }
}
