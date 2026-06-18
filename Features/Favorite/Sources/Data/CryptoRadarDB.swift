//
//  FavoriteRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 17/06/26.
//

import Foundation
import SwiftData

public final class CryptoRadarDB: FavoriteRepositoryProtocol {

    private let container: ModelContainer

    private var context: ModelContext {ModelContext(container)}

    public init() {
        container = try! ModelContainer( for: FavoriteCryptoEntity.self)
    }

    public func getFavorites() -> [FavoriteCrypto] {

        let descriptor = FetchDescriptor<FavoriteCryptoEntity>()

        let entities = (try? context.fetch(descriptor)) ?? []

        return entities.map {
            $0.toDomain()
        }
    }

    public func addFavorite(_ crypto:FavoriteCrypto) {
        context.insert(crypto.toEntity())
        try? context.save()
    }

    public func removeFavorite(id:String) {

        let descriptor = FetchDescriptor<FavoriteCryptoEntity>()

        let entities = (try? context.fetch(descriptor)) ?? []

        if let item = entities.first(where: {$0.id == id}) {
            context.delete(item)
            try? context.save()
        }
    }

    public func isFavorite(id:String) -> Bool {
        return getFavorites().contains { $0.id == id }
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
            currentPrice: currentPrice
        )
    }
}

private extension FavoriteCrypto {
    func toEntity() -> FavoriteCryptoEntity {
        FavoriteCryptoEntity(
            id: id,
            name: name,
            symbol: symbol,
            image: image,
            currentPrice: currentPrice
        )
    }
}
