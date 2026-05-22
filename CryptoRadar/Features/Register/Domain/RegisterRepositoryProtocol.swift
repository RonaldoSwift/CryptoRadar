//
//  RegisterRepository.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/05/26.
//

import Foundation

protocol RegisterRepositoryProtocol {
    
    func register(
        email: String,
        password: String
    ) async throws -> String
}
