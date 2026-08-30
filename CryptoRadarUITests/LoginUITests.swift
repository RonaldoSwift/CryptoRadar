//
//  LoginUITests.swift
//  CryptoRadarUITests
//
//  Created by Ronaldo Andre on 29/08/26.
//

import Foundation
import XCTest

final class LoginUITests: XCTestCase {

    func testInvalidLoginShowsErrorMessage() {
        let app = XCUIApplication()

        app.launchArguments.append("-uiTesting")
        app.launch()

        let emailTextField = app.textFields["loginEmailTextField"]

        XCTAssertTrue(
            emailTextField.waitForExistence(timeout: 5)
        )

        emailTextField.tap()
        emailTextField.typeText("correo-invalido")

        let passwordTextField = app.secureTextFields["loginPasswordTextField"]

        XCTAssertTrue(
            passwordTextField.waitForExistence(timeout: 5)
        )

        passwordTextField.tap()
        passwordTextField.typeText("123")

        let loginButton = app.buttons["loginButton"]

        XCTAssertTrue(
            loginButton.waitForExistence(timeout: 5)
        )

        loginButton.tap()

        let errorMessage = app.staticTexts["loginErrorMessage"]

        XCTAssertTrue(
            errorMessage.waitForExistence(timeout: 5)
        )
    }
}
