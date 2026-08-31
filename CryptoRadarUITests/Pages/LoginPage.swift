//
//  LoginPage.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 31/08/26.
//

import Foundation
import XCTest

struct LoginPage {
    
    private let app: XCUIApplication
    
    // Elementos de la pantalla de Login
    //Dentro de la aplicación, busca el TextField cuyo accessibilityIdentifier sea loginEmailTextField.
    let emailField: XCUIElement
    let passwordField: XCUIElement
    let loginButton: XCUIElement
    let errorMessage: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        
        emailField = app.textFields["login.email.textfield"]
        passwordField = app.secureTextFields["login.password.textfield"]
        loginButton = app.buttons["login.button"]
        errorMessage = app.staticTexts["login.error.message"]
    }
    
    //Las funciones encapsulan las acciones
    func escribirEmail(_ email: String) {
        XCTAssertTrue(
            emailField.waitForExistence(timeout: 5)
        )
        
        emailField.tap()
        emailField.typeText(email)
    }
    
    func escribirPassword(_ password: String) {
        XCTAssertTrue(
            passwordField.waitForExistence(timeout: 5)
        )
        
        passwordField.tap()
        passwordField.typeText(password)
    }
    
    func clickLogin() {
        XCTAssertTrue(
            loginButton.waitForExistence(timeout: 5)
        )
        
        loginButton.tap()
    }
}
