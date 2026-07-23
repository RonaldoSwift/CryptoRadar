//
//  DeepLink.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 22/07/26.
//

import Foundation

enum DeepLink: Equatable {
    case crypto(id: String)
    case favorites
    
    init?(url: URL) {
        guard url.scheme == "cryptoradar" else {
            return nil
        }
        switch url.host {
        case "crypto":
            let components = url.pathComponents
            guard components.count > 1 else {
                return nil
            }
            self = .crypto(id: components[1])
        case "favorites":
            self = .favorites
        default:
            return nil
        }
    }
}
