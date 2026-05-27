//
//  LoginRepositoryProtocol.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation

public protocol LoginRepositoryProtocol {
    
    func login(
        email: String,
        password: String
    ) async throws -> String
}
