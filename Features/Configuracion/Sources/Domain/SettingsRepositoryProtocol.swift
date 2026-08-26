//
//  SettingsRepositoryProtocol.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 25/06/26.
//

import Foundation

public protocol SettingsRepositoryProtocol {

    func getCurrency() -> Settings

    func saveCurrency(_ currency: Settings)

    func getNotificationsEnabled() -> Bool

    func saveNotificationsEnabled(_ enabled: Bool)

    func getTheme() -> AppTheme

    func saveTheme(_ theme: AppTheme)
    
    func requestNotificationPermission(
        completion: @escaping (Bool) -> Void
    )
}
