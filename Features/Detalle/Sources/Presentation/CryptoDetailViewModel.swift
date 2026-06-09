//
//  CryptoDetailViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 8/06/26.
//

import Foundation
import Combine

@MainActor
public final class CryptoDetailViewModel: ObservableObject {
    
    @Published private(set)var crypto: CryptoDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showFullDescription = false
    
    private let repository: CryptoDetailRepositoryProtocol
    
    public init(repository:CryptoDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    public func load(id: String) {

        print("ID recibido:", id)

        isLoading = true
        errorMessage = nil

        Task {
            do {

                let result = try await repository.getCryptoDetail(id: id)

                print("Detalle OK:", result)

                crypto = result

            } catch {

                print("ERROR DETALLE:", error)

                errorMessage = CryptoDetailStrings.errorDetail
            }

            isLoading = false
        }
    }
    
    public func toggleFavorite() {
        
        guard var crypto
        else {
            return
        }
        crypto.isFavorite.toggle()
        self.crypto = crypto
    }
    
    public func toggleDescription() {
        showFullDescription.toggle()
    }
}
