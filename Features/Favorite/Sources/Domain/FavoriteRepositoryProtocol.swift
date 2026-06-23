//
//  FavoriteRepositoryProtocol.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 17/06/26.
//

import Foundation

public protocol FavoriteRepositoryProtocol {

    func getFavorites() -> [FavoriteCrypto]

    func addFavorite(_ crypto: FavoriteCrypto)

    func removeFavorite(id: String)

    func isFavorite(id: String) -> Bool
}
