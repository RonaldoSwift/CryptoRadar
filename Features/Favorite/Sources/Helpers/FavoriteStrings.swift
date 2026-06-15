//
//  FavoriteStrings.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/06/26.
//

import Foundation

enum FavoriteStrings {
    
    static let title = localized("favorite.title")
    static let empty = localized("favorite.empty")
    static let emptyDescription = localized("favorite.empty.description")
    static let add = localized("favorite.add")
    static let remove = localized("favorite.remove")
    static let searchFavorite = localized("favorite.search")

    private static func localized(_ key: String.LocalizationValue) -> String {

        String(localized: key,bundle: Bundle(
                for: FavoriteListViewModel.self
            )
        )
    }
}
