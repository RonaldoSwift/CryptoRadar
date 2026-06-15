//
//  CryptoListViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation
import Combine
import CryptoList

@MainActor
public final class CryptoListViewModel: ObservableObject {
    
    @Published public private(set) var cryptos: [Crypto] = []
    @Published public private(set) var isLoading = false
    @Published public private(set) var errorMessage: String?
    @Published var searchText: String = ""
    
    @Published var favoriteIds: Set<String> = []
    
    //Filtrado de criptomonedas según el texto de búsqueda
    var filteredCryptos: [Crypto] {
        if searchText.isEmpty {
            return cryptos
        }
        return cryptos.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private let repository: CryptoListRepositoryProtocol
    
    public init(repository:CryptoListRepositoryProtocol) {
        self.repository = repository
    }
    
    public func loadCryptos() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                cryptos = try await repository.getTopCryptos()
            } catch {
                errorMessage = CryptoListStrings.errorMesageCrypto
            }
            isLoading = false
        }
    }
    
    public func refresh() async {
        errorMessage = nil
        do {
            cryptos = try await repository.getTopCryptos()
        } catch {
            errorMessage = CryptoListStrings.errorUpdate
        }
    }
    
    public func toggleFavorite(id: String) {
        
        if favoriteIds.contains(id) {
            favoriteIds.remove(id)
        } else {
            favoriteIds.insert(id)
        }
    }
    
    public func isFavorite(id: String) -> Bool {
        favoriteIds.contains(id)
    }
    
    
    public var favoriteCryptos: [Crypto] {

        cryptos.filter {

            favoriteIds.contains(
                $0.id
            )
        }
    }
}
