//
//  LoginUITests.swift
//  CryptoRadarUITests
//
//  Created by Ronaldo Andre on 22/08/26.
//

// ┌─────────────────────────────────────────────────────────────────┐
// │  UI Tests (E2E — End to End)                                    │
// │                                                                 │
// │  Lanza el app real en el simulador e interactúa como un         │
// │  usuario real: tap, typeText, scroll.                           │
// │                                                                 │
// │  Úsalos solo para los flujos críticos porque son lentos         │
// │  (~segundos por test). Para verificar estado de la UI           │
// │  (botón disabled, texto de un label) usa ViewInspector.         │
// └─────────────────────────────────────────────────────────────────┘

import XCTest

final class LoginUITests: XCTestCase {

    var app: XCUIApplication!
    var loginPage: LoginPage!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        loginPage = LoginPage(app: app)
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Validation

    @MainActor
    func testLogin_emptyEmail_showsErrorMessage() throws {
        XCTAssertTrue(loginPage.waitUntilReady())

        loginPage.tapLogin()

        XCTAssertTrue(loginPage.errorMessage.waitForExistence(timeout: 2))
    }

    @MainActor
    func testLogin_invalidEmail_showsErrorMessage() throws {
        XCTAssertTrue(loginPage.waitUntilReady())

        loginPage
            .typeEmail("not-an-email")
            .typePassword("password123")
            .tapLogin()

        XCTAssertTrue(loginPage.errorMessage.waitForExistence(timeout: 2))
    }

    @MainActor
    func testLogin_emptyPassword_showsErrorMessage() throws {
        XCTAssertTrue(loginPage.waitUntilReady())

        loginPage
            .typeEmail("user@example.com")
            .tapLogin()

        XCTAssertTrue(loginPage.errorMessage.waitForExistence(timeout: 2))
    }

    @MainActor
    func testLogin_passwordTooShort_showsErrorMessage() throws {
        XCTAssertTrue(loginPage.waitUntilReady())

        loginPage
            .typeEmail("user@example.com")
            .typePassword("123")
            .tapLogin()

        XCTAssertTrue(loginPage.errorMessage.waitForExistence(timeout: 2))
    }
}

