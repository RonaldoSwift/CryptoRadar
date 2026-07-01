//
//  SettingsAssembly.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 25/06/26.
//

import Foundation
import Swinject

@MainActor
public final class SettingsAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(SettingsData.self) { _ in
            SettingsData()
        }
        
        container.register(SettingsRepositoryProtocol.self) { resolver in
            SettingsRepository(data:resolver.resolve(SettingsData.self)!)
        }
        
        container.register(SettingsViewModel.self) { resolver in
            SettingsViewModel(repository:resolver.resolve(SettingsRepositoryProtocol.self)!)
        }
    }
}
