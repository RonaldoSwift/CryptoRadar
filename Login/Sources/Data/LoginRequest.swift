//
//  LoginRequest.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation

public struct LoginRequest: Encodable {
    let email: String
    let password: String
}
