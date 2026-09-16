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
        guard url.scheme?.lowercased() == "cryptoradar" else {
            return nil
        }
        switch url.host?.lowercased() {
        case "crypto":
            let components = url.pathComponents.filter { $0 != "/" }
            guard let id = components.first, !id.isEmpty else {
                return nil
            }
            self = .crypto(id: id)
        case "favorites":
            self = .favorites
        default:
            return nil
        }
    }
}
