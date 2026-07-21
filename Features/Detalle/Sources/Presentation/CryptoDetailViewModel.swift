//
//  CryptoDetailViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 8/06/26.
//
//
//  CryptoDetailViewModel.swift
//  CryptoRadar
//

import Foundation
import Combine
import Favorite

@MainActor
public final class CryptoDetailViewModel: ObservableObject {

    @Published private(set) var crypto: CryptoDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showFullDescription = false
    @Published var isFavorite = false

    private let repository: CryptoDetailRepositoryProtocol
    private let favoriteRepository: FavoriteRepositoryProtocol

    public init(repository: CryptoDetailRepositoryProtocol,favoriteRepository: FavoriteRepositoryProtocol) {
        self.repository = repository
        self.favoriteRepository = favoriteRepository
    }

    public func load(id: String) {

        #if DEBUG
        print("ID recibido:", id)
        #endif

        isLoading = true
        errorMessage = nil

        Task {
            do {
                var result = try await repository.getCryptoDetail(id: id)
                result.isFavorite = favoriteRepository.isFavorite(id: id)
                isFavorite = result.isFavorite
                #if DEBUG
                print("Detalle OK:", result)
                #endif

                crypto = result
            } catch {
                
                #if DEBUG
                print("ERROR DETALLE:", error)
                #endif

                errorMessage = CryptoDetailStrings.errorDetail
            }
            isLoading = false
        }
    }

    public func toggleFavorite() {

        guard var crypto = self.crypto else {
            return
        }

        if favoriteRepository.isFavorite(id: crypto.id) {
            favoriteRepository.removeFavorite(id: crypto.id)
        } else {
            favoriteRepository.addFavorite(
                FavoriteCrypto(
                    id: crypto.id,
                    name: crypto.name,
                    symbol: crypto.description,
                    image: crypto.image,
                    currentPrice: crypto.currentPrice
                )
            )
        }
        crypto.isFavorite = favoriteRepository.isFavorite(id: crypto.id)
        self.crypto = crypto
        isFavorite = favoriteRepository.isFavorite(id: crypto.id)
    }
    
    public func toggleDescription() {
        showFullDescription.toggle()
    }
}
