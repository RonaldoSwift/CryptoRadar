//
//  SearchResponse.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/07/26.
//

import Foundation

public struct SearchResponse: Decodable {
    public let coins: [SearchCoinResponse]
}

public struct SearchCoinResponse: Decodable, Identifiable {
    public let id: String
    public let name: String
    public let symbol: String
    public let thumb: String
}
