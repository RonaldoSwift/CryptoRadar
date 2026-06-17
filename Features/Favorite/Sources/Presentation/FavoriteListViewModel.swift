//
//  FavoriteListViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/06/26.
//

import Foundation
import SwiftData
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

    public func loadFavorites(context: ModelContext) {
        let descriptor = FetchDescriptor<FavoriteCrypto>()
        favorites = (try? context.fetch(descriptor)) ?? []
    }

    public func toggleFavorite(_ crypto: FavoriteCrypto,context: ModelContext) {

        if let current = favorites.first(where: { $0.id == crypto.id}) {
            context.delete(current)
        } else {
            context.insert(crypto)
        }
        try? context.save()

        loadFavorites(context:context)
    }

    public func removeFavorite(id: String, context:ModelContext) {

        if let favorite = favorites.first(where: { $0.id == id}) {
            context.delete(favorite)
            try? context.save()
        }
        loadFavorites(context:context)
    }

    public func isFavorite(id: String) -> Bool {
        favorites.contains {
            $0.id == id
        }
    }
}
