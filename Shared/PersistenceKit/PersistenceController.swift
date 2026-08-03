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
        do {
            container = try ModelContainer(for: FavoriteCryptoEntity.self)
            context = ModelContext(container)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    public func getFavorites() -> [FavoriteCryptoEntity] {
        let descriptor = FetchDescriptor<FavoriteCryptoEntity>()
        let entities = (try? context.fetch(descriptor)) ?? []
        return entities
    }
    
    public func addFavorite(_ crypto: FavoriteCryptoEntity) {
        context.insert(crypto)
        try? context.save()
    }
    
    public func removeFavorite(id: String) {
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
