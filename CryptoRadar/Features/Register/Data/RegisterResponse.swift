//
//  RegisterResponse.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/05/26.
//

import Foundation

struct RegisterResponse: Decodable {
    let id: Int
    let token: String
}
