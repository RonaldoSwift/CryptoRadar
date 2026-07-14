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

extension Settings {
    func toEntity() -> SettingsEntity {
        SettingsEntity(rawValue: rawValue) ?? .usd
    }
}
