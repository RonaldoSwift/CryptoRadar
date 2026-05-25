//
//  LoginStrings.swift
//  Login
//
//  Created by Ronaldo Andre on 25/05/26.
//

import Foundation

enum LoginStrings {
    
    static let appName =
    localized("Login.AppName")
    
    static let title =
    localized("Login.Title")
    
    static let subtitle =
    localized("Login.Subtitle")
    
    static let emailTitle =
    localized("Login.EmailTitle")
    
    static let emailPlaceholder =
    localized("Login.EmailPlaceholder")
    
    static let passwordTitle =
    localized("Login.PasswordTitle")
    
    static let passwordPlaceholder =
    localized("Login.PasswordPlaceholder")
    
    static let button =
    localized("Login.Button")
    
    static let forgotPassword =
    localized("Login.ForgotPassword")
    
    static let accountQuestion =
    localized("Login.AccountQuestion")
    
    static let register =
    localized("Login.Register")
    
    static let successTitle =
    localized("Login.SuccessTitle")
    
    static let successMessage =
    localized("Login.SuccessMessage")
    
    private static func localized(
        _ key: String.LocalizationValue
    ) -> String {
        String(
            localized: key,
            bundle: Bundle(
                for: LoginViewModel.self
            )
        )
    }
}
