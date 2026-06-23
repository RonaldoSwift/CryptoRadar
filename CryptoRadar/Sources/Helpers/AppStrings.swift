//
//  AppStrings.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 18/06/26.
//

import Foundation
import Favorite

enum AppStrings {

    static let market = localized("CryptoAp.market")
    static let favorite = localized("CryptoAp.Favorite")

    private static func localized(_ key:String.LocalizationValue) -> String {
        String(localized: key)
    }
}
