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
    
    static let invalidEmail =
    localized("Login.Error.InvalidEmail")

    static let passwordMinLength =
    localized("Login.Error.PasswordMinLength")

    static let emptyEmail =
    localized("Login.Error.EmptyEmail")

    static let emptyPassword =
    localized("Login.Error.EmptyPassword")
    
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

// MARK: - String Extensions

public extension String {
    
    var isValidEmail: Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        
        return NSPredicate(
            format: "SELF MATCHES %@",
            emailRegex)
            .evaluate(with: self)
    }
}
