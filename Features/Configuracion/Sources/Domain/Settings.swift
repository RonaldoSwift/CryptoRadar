//
//  Settings.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 25/06/26.
//

import Foundation

public enum Settings: String, CaseIterable {
    case usd = "USD"
    case mxn = "MXN"
    case eur = "EUR"
}

public enum AppTheme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}
