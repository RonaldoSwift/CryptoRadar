//
//  RegisterRepositoryProtocol.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 26/05/26.
//

import Foundation

public protocol RegisterRepositoryProtocol {
    
    func register(
        email: String,
        password: String
    ) async throws -> String
}
