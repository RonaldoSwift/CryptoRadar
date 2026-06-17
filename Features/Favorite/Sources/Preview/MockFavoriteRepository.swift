//
//  MockFavoriteRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 17/06/26.
//

import Foundation

public final class MockFavoriteRepository: FavoriteRepositoryProtocol {
    
    public init() {}
    
    public func getFavorites() -> [FavoriteCrypto] {
        []
    }
    
    public func addFavorite(_ crypto: FavoriteCrypto) {}
    
    public func removeFavorite(id: String) {}
    
    public func isFavorite(id: String) -> Bool {
        false
    }
}
