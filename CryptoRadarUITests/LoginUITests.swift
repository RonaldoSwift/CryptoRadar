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
        
        let loginPage = LoginPage(app: app)
        
        loginPage.escribirEmail("correo-invalido")
        loginPage.escribirPassword("123")
        loginPage.clickLogin()
        
        XCTAssertTrue(
            loginPage.errorMessage.waitForExistence(timeout: 5)
        )
    }
    
    //correo es vacío, validar que el mensage de error exista.
    func testEmptyEmailShowsErrorMessage() {
        
        let app = XCUIApplication()
        
        app.launchArguments.append("-uiTesting")
        app.launch()
        
        let loginPage = LoginPage(app: app)
        
        // No escribimos ningún correo.
        loginPage.escribirPassword("123")
        loginPage.clickLogin()
        
        XCTAssertTrue(
            loginPage.errorMessage.waitForExistence(timeout: 5)
        )
    }
    
    //password es vacío, validar que el mensaje de error exista.
    func testEmptyPasswordShowsErrorMessage() {
        
        let app = XCUIApplication()
        
        app.launchArguments.append("-uiTesting")
        app.launch()
        
        let loginPage = LoginPage(app: app)
        
        // Escribimos un correo, pero dejamos la contraseña vacía.
        loginPage.escribirEmail("correo@ejemplo.com")
        loginPage.clickLogin()
        
        XCTAssertTrue(
            loginPage.errorMessage.waitForExistence(timeout: 5)
        )
    }
}
