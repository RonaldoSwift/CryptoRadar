//
//  RegisterStrings.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 13/07/26.
//

import Foundation

enum RegisterStrings {

    static let appName = localized("Register.AppName")
    static let title = localized("Register.Title")
    static let subtitle = localized("Register.Subtitle")

    static let nameTitle = localized("Register.NameTitle")
    static let namePlaceholder = localized("Register.NamePlaceholder")

    static let emailTitle = localized("Register.EmailTitle")
    static let emailPlaceholder = localized("Register.EmailPlaceholder")

    static let passwordTitle = localized("Register.PasswordTitle")
    static let passwordPlaceholder = localized("Register.PasswordPlaceholder")

    static let confirmPasswordTitle = localized("Register.ConfirmPasswordTitle")
    static let confirmPasswordPlaceholder = localized("Register.ConfirmPasswordPlaceholder")

    static let createButton = localized("Register.CreateButton")
    static let accountQuestion = localized("Register.AccountQuestion")
    static let login = localized("Register.Login")
    static let terms = localized("Register.Terms")

    static let successTitle = localized("Register.SuccessTitle")
    static let successMessage = localized("Register.SuccessMessage")

    static let passwordMismatch = localized("Register.PasswordMismatch")

    private static func localized(_ key: String.LocalizationValue) -> String {
        String(
            localized: key,
            bundle: Bundle(for: RegisterViewModel.self)
        )
    }
}
