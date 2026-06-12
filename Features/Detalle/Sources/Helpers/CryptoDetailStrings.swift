//
//  CryptoDetailStrings.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 9/06/26.
//

import Foundation

enum CryptoDetailStrings {
    
    static let errorDetail = localized("CryptoDetail.Error.Detail")
    static let currentPrice = localized("CryptoDetail.CurrentPrice")
    static let statistics = localized("CryptoDetail.Statistics")
    static let graph = localized("CryptoDetail.Graph")
    static let readMore = localized("CryptoDetail.ReadMore")
    static let readLess = localized("CryptoDetail.ReadLess")
    static func about(_ name: String) -> String {
        localized("CryptoDetail.About") + " \(name)"
    }
    
    private static func localized(_ key: String.LocalizationValue) -> String {
        String(
            localized: key,
            bundle: Bundle(for: CryptoDetailViewModel.self)
        )
    }
}
