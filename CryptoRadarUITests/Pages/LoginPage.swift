//
//  LoginPage.swift
//  CryptoRadarUITests
//
//  Created by Ronaldo Andre on 22/08/26.
//

// Page Object Model (POM)
//
// Encapsula todos los elementos y acciones de la pantalla de Login.
// Si cambia un accessibilityIdentifier o un texto solo se edita aquí,
// no en cada test individualmente.

import XCTest

struct LoginPage {

    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    // MARK: - Elementos

    var emailField: XCUIElement    { app.textFields["login.email.field"] }
    var passwordField: XCUIElement { app.secureTextFields["login.password.field"] }
    var loginButton: XCUIElement   { app.buttons["login.button"] }
    var errorMessage: XCUIElement  { app.staticTexts["login.error.message"] }

    // MARK: - Acciones

    @discardableResult
    func typeEmail(_ email: String) -> Self {
        emailField.tap()
        emailField.typeText(email)
        return self
    }

    @discardableResult
    func typePassword(_ password: String) -> Self {
        passwordField.tap()
        passwordField.typeText(password)
        return self
    }

    func tapLogin() {
        loginButton.tap()
    }

    // MARK: - Esperas

    func waitUntilReady(timeout: TimeInterval = 3) -> Bool {
        loginButton.waitForExistence(timeout: timeout)
    }
}
