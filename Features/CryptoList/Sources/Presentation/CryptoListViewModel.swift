//
//  CryptoListViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation
public import Combine

@MainActor
public final class CryptoListViewModel: ObservableObject {
    
    @Published var cryptos: [CryptoResponse] = []
    
    @Published var isLoading = false
    
    @Published var errorMessage: String?
    
    private let repository: CryptoListRepositoryProtocol
    
    public init(repository:CryptoListRepositoryProtocol) {
        self.repository =
        repository
    }
    
    public func loadCryptos() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                cryptos = try await repository.getTopCryptos()
            } catch {
                errorMessage = "No pudimos cargar las criptomonedas. Intenta nuevamente."
            }
            isLoading = false
        }
    }
    
    public func refresh() async {
        
        do {
            cryptos =
            try await repository.getTopCryptos()
        } catch {
            errorMessage = "No pudimos actualizar."
        }
    }
}
