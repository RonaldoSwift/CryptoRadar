//
//  KeychainManager.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 28/05/26.
//

import Foundation
import Security

public final class KeychainManager {
    
    public static let shared = KeychainManager()
    
    private init() {}
    
    // Grabar un token en el Keychain
    public func saveToken(_ token: String) {
        let data = token.data(using: .utf8)!

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken",
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    // Obtener token
    public func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &dataTypeRef
        )
        
        if status == errSecSuccess,
           let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    // Eliminar token
    public func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken"
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
