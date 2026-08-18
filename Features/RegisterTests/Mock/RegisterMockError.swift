//
//  RegisterMockError.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 17/08/26.
//

import Foundation

enum RegisterMockError: LocalizedError {
    case registerFailed
    
    var errorDescription: String? {
        "Register Failed"
    }
}
