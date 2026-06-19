//
//  FavoriteRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 17/06/26.
//

import Foundation
import SwiftData

public final class PersistenceController {
    
    private var container: ModelContainer
    private let context: ModelContext
    
    public init() {
        container = try! ModelContainer( for: FavoriteCryptoEntity.self)
        do {
            container = try ModelContainer(for: FavoriteCryptoEntity.self)
            context = ModelContext(container)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    public func getFavorites() -> [FavoriteCrypto] {
        
        let descriptor = FetchDescriptor<FavoriteCryptoEntity>()
        
        let entities = (try? context.fetch(descriptor)) ?? []
        
        return entities.map {
            $0.toDomain()
        }
    }
    
    // no devuleve modelo de negocio sino la de modelo de datos
    public func addFavorite(_ crypto:FavoriteCrypto) {
        context.insert(crypto.toEntity())
        try? context.save()
    }
    
    public func removeFavorite(id:String) {
        
        //let descriptor = FetchDescriptor<FavoriteCryptoEntity>()
        var descriptor = FetchDescriptor<FavoriteCryptoEntity>(
            predicate: #Predicate { $0.id == id }
        )
        descriptor.fetchLimit = 1
        
        if let item = (try? context.fetch(descriptor))?.first {
            context.delete(item)
            try? context.save()
        }
    }
    
    public func isFavorite(id: String) -> Bool {
        var descriptor = FetchDescriptor<FavoriteCryptoEntity>(
            predicate: #Predicate { $0.id == id }
        )
        descriptor.fetchLimit = 1
        return (try? context.fetch(descriptor))?.isEmpty == false
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
