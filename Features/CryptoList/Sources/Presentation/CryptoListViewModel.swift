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
    private var searchTask: Task<Void, Never>?
    
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
    
    public func searchCryptos() {
        searchTask?.cancel()
        if searchText.isEmpty {
            loadCryptos()
            return
        }
        isLoading = true
        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { return }
            do {
                cryptos = try await repository.searchCryptos(query: searchText)
            } catch {
                errorMessage = CryptoListStrings.errorMesageCrypto
            }
            isLoading = false
        }
    }
}
