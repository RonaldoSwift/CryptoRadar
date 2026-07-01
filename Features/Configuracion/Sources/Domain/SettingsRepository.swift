//
//  SettingsRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 25/06/26.
//

import Foundation

public final class SettingsRepository: SettingsRepositoryProtocol {
    
    private let data: SettingsData
    
    public init(data: SettingsData) {
        self.data = data
    }
    
    public func getCurrency() -> Settings {
        data.getCurrency().toDomain()
    }
    
    public func saveCurrency(_ currency: Settings) {
        data.saveCurrency(currency.toEntity())
    }
    
    public func getNotificationsEnabled() -> Bool {
        data.getNotificationsEnabled()
    }
    
    public func saveNotificationsEnabled(_ enabled: Bool) {
        data.saveNotificationsEnabled(enabled)
    }
}
