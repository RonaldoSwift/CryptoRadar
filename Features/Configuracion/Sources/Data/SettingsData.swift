//
//  SettingData.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 25/06/26.
//

import Foundation

public final class SettingsData {

    private enum Keys {
        static let currency = "base_currency"
        static let notifications = "notifications_enabled"
    }

    private let defaults = UserDefaults.standard

    public init() {}

    public func getCurrency() -> SettingsEntity {
        let value = defaults.string(forKey: Keys.currency)
        return SettingsEntity(rawValue: value ?? "") ?? .usd
    }

    public func saveCurrency(_ currency: SettingsEntity) {
        defaults.set(currency.rawValue,forKey: Keys.currency)
    }

    public func getNotificationsEnabled() -> Bool {
        defaults.bool(forKey: Keys.notifications)
    }

    public func saveNotificationsEnabled(_ enabled: Bool) {
        defaults.set(enabled,forKey: Keys.notifications)
    }
}
