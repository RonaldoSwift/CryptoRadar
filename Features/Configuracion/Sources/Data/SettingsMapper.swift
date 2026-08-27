//
//  SettingsMapper.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 25/06/26.
//

import Foundation

extension SettingsEntity {
    
    func toDomain() -> Settings {
        Settings(rawValue: rawValue) ?? .usd
    }
}

public extension AppThemeEntity {
    func toDomain() -> AppTheme {
        AppTheme(rawValue: rawValue) ?? .light
    }
}

public extension AppTheme {
    func toEntity() -> AppThemeEntity {
        AppThemeEntity(rawValue: rawValue) ?? .light
    }
}

extension Settings {
    func toEntity() -> SettingsEntity {
        SettingsEntity(rawValue: rawValue) ?? .usd
    }
}
