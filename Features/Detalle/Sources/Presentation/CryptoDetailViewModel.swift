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

@MainActor
public final class CryptoDetailViewModel: ObservableObject {

    @Published private(set) var crypto: CryptoDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showFullDescription = false

    private let repository: CryptoDetailRepositoryProtocol

    public init(repository: CryptoDetailRepositoryProtocol) {
        self.repository = repository
    }

    public func load(id: String) {

        #if DEBUG
        print("ID recibido:", id)
        #endif

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let result = try await repository.getCryptoDetail(id: id)

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
        crypto.isFavorite.toggle()
        self.crypto = crypto
    }
    
    public func toggleDescription() {
        showFullDescription.toggle()
    }
}
