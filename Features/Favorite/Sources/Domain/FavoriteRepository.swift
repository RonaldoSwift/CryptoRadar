//
//  FavoriteRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 17/06/26.
//

import Foundation
import SwiftData

public final class FavoriteRepository: FavoriteRepositoryProtocol {
    
    private let container: ModelContainer
    
    private var context: ModelContext {
        ModelContext(container)
    }
    
    public init() {
        
        container = try! ModelContainer(for: FavoriteCrypto.self)
    }
    
    public func getFavorites() -> [FavoriteCrypto] {
        
        let descriptor = FetchDescriptor<FavoriteCrypto>()
        
        return (
            try? context.fetch(descriptor)
        ) ?? []
    }
    
    public func addFavorite(_ crypto: FavoriteCrypto) {
        context.insert(crypto)
        try? context.save()
    }
    
    public func removeFavorite(id:String) {
        
        let descriptor = FetchDescriptor<FavoriteCrypto>()
        
        let items = ( try? context.fetch(descriptor)) ?? []
        
        if let item = items.first(where: {$0.id == id}) {
            context.delete(item)
            try? context.save()
        }
    }
    
    public func isFavorite(id:String) -> Bool {
        getFavorites().contains {
            $0.id == id
        }
    }
}
