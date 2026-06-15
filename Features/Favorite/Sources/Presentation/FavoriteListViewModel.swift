//
//  FavoriteListViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/06/26.
//

import Foundation
import Combine

@MainActor
public final class FavoriteListViewModel: ObservableObject {
    
    @Published public var favorites: [FavoriteCrypto] = []
    
    @Published public var searchText = ""
    
    public init() {}
    
    public var filteredFavorites: [FavoriteCrypto] {
        if searchText.isEmpty {
            return favorites
        }
        return favorites.filter {
            $0.name.localizedCaseInsensitiveContains(
                searchText
            )
        }
    }
    
    public func addFavorite(_ crypto: FavoriteCrypto) {
        
        guard !favorites.contains(
            where: {
                $0.id == crypto.id
            }
        )
        else {
            return
        }
        favorites.append(crypto)
    }
    
    public func removeFavorite(id: String) {
        favorites.removeAll {
            $0.id == id
        }
    }
    
    public func toggleFavorite(_ crypto:FavoriteCrypto) {
        
        if isFavorite(id:crypto.id) {
            removeFavorite(id:crypto.id)
        } else {
            addFavorite(crypto)
        }
    }
    
    public func isFavorite(id: String) -> Bool {
        favorites.contains {
            $0.id == id
        }
    }
}
