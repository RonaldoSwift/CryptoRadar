//
//  RegisterRequest.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 26/05/26.
//

import Foundation

struct RegisterRequest: Encodable {
    let email: String
    let password: String
}
