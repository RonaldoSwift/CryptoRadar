//
//  CryptoDetailResponse.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 8/06/26.
//

import Foundation

public struct CryptoDetailResponse: Codable {
    
    public let id: String
    public let name: String
    public let image: ImageResponse
    public let description: DescriptionResponse
    public let marketData: MarketDataResponse
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case description
        case marketData = "market_data"
    }
}

public struct ImageResponse: Codable {
    public let large: String
}

public struct DescriptionResponse: Codable {
    public let en: String
}

public struct MarketDataResponse: Codable {
    
    public let currentPrice: [String: Double]
    
    enum CodingKeys: String,CodingKey {
        case currentPrice = "current_price"
    }
}
