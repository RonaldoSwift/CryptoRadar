//
//  FavoriteAssembly.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 16/06/26.
//

import Foundation
import Swinject

@MainActor
public final class FavoriteAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(FavoriteListViewModel.self) { _ in
            FavoriteListViewModel()
        }
    }
}
