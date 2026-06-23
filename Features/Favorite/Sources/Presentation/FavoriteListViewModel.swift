//
//  FavoriteListViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/06/26.
//

import Foundation
import Combine

@MainActor
public final class FavoriteListViewModel:
    ObservableObject {
    
    @Published public private(set) var favorites: [FavoriteCrypto] = []
    @Published public var searchText = ""
    
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public var filteredFavorites: [FavoriteCrypto] {
        
        if searchText.isEmpty {
            return favorites
        }
        
        return favorites.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    public func load() {
        favorites = repository.getFavorites()
    }
    
    public func toggleFavorite(_ crypto: FavoriteCrypto) {
        if isFavorite(id:crypto.id) {
            repository.removeFavorite(id:crypto.id)
        } else {
            repository.addFavorite(crypto)
        }
        load()
    }
    
    public func removeFavorite(id:String) {
        repository.removeFavorite(id:id)
        load()
    }
    
    public func isFavorite(id:String) -> Bool {
        favorites.contains {
            $0.id == id
        }
    }
}
