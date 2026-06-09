//
//  CryptoDetailStrings.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 9/06/26.
//

import Foundation

private final class BundleFinder {}

public enum CryptoDetailStrings {
    
    public static let errorDetail = localized("No pudimos cargar el detalle.")
    public static let currentPrice = localized("CURRENT PRICE")
    public static let currentDescription = localized("Bitcoin (BTC) is a decentralized digital currency that allows peer-to-peer transactions without relying on a central authority.")
    
    public static func about(_ name: String) -> String {
        localized("About \(name)")
    }
    
    private static func localized(_ key: String.LocalizationValue) -> String {
        String(
            localized: key,
            bundle:Bundle(for:BundleFinder.self)
        )
    }
}
