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
}
