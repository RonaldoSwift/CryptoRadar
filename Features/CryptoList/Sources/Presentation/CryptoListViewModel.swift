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
    @Published var showErrorAlert = false
    @Published var searchText: String = ""
    private var searchTask: Task<Void, Never>?
    private var hasLoaded = false
    
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
                if cryptos.isEmpty {
                    // primera carga
                } else {
                    showErrorAlert = true
                }
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
            showErrorAlert = true
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
                showErrorAlert = true
            }
            isLoading = false
        }
    }
    
    public func loadIfNeeded() {
        guard !hasLoaded else { return }
        hasLoaded = true
        if searchText.isEmpty {
            loadCryptos()
        } else {
            searchCryptos()
        }
    }
}
