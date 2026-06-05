//
//  CryptoList.swift
//  CryptoList
//
//  Created by Ronaldo Andre on 4/06/26.
//

import Foundation

private final class BundleFinder {}

public enum CryptoListStrings {

    public static let title = localized("Search Assets")

    public static let searchPlaceholder = localized("SearchPlaceholder")
    public static let errorMesageCrypto = localized("No pudimos cargar las criptomonedas. Intenta nuevamente.")
    
    public static let errorUpdate = localized("No pudimos actualizar.")
    public static let retry = localized("Retry")

    private static func localized(_ key: String.LocalizationValue) -> String {
        String(
            localized: key,
            bundle: Bundle(
                for: BundleFinder.self
            )
        )
    }
}
