//
//  SettingsViewModel.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 25/06/26.
//

import Foundation
import Combine
import StorageKit

@MainActor
public final class SettingsViewModel: ObservableObject {
    
    @Published public var currency: Settings = .usd
    
    @Published public var notificationsEnabled = false
    
   // public var onLogout: (() -> Void)?
    
    private let repository: SettingsRepositoryProtocol
    
    public init(repository:SettingsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func load() {
        currency = repository.getCurrency()
        notificationsEnabled = repository.getNotificationsEnabled()
    }
    
    public func logout() {
        KeychainManager.shared.deleteToken()
    }
    
    public func updateCurrency(_ currency: Settings) {
        self.currency = currency
        repository.saveCurrency(currency)
    }
    
    public func updateNotifications(_ enabled: Bool) {
        if enabled {
            repository.requestNotificationPermission { granted in
                self.notificationsEnabled = granted
                self.repository.saveNotificationsEnabled(granted)
            }
        } else {
            notificationsEnabled = false
            repository.saveNotificationsEnabled(false)
        }
    }
}
