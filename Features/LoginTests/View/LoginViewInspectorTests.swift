//
//  LoginViewInspectorTests.swift
//  LoginTests
//
//  Created by Ronaldo Andre on 22/08/26.
//

// ┌─────────────────────────────────────────────────────────────────┐
// │  ViewInspector                                                  │
// │                                                                 │
// │  Prueba el estado de la UI sin lanzar el simulador.             │
// │  Corre en milisegundos. Ideal para verificar:                   │
// │    • Si un elemento está visible o no                           │
// │    • Si un botón está deshabilitado                             │
// │    • El texto exacto de un label                                │
// │                                                                 │
// │  NO prueba interacción real del usuario (tap, scroll, etc.)     │
// └─────────────────────────────────────────────────────────────────┘

import XCTest
import ViewInspector
@testable import Login

@MainActor
final class LoginViewInspectorTests: XCTestCase {

    // El botón de login debe deshabilitarse mientras se procesa la petición,
    // para evitar que el usuario haga tap múltiples veces.
    func testLoginButton_isDisabled_whenLoading() throws {
        let vm = LoginViewModel(repository: MockLoginRepository(result: .success("token")))
        vm.isLoading = true

        let sut = LoginView(viewModel: vm)

        let button = try sut.inspect().find {
            (try? $0.accessibilityIdentifier()) == "login.button"
        }
        XCTAssertTrue(try button.isDisabled())
    }

    // En estado inicial sin carga el botón debe estar habilitado.
    func testLoginButton_isEnabled_initially() throws {
        let vm = LoginViewModel(repository: MockLoginRepository(result: .success("token")))

        let sut = LoginView(viewModel: vm)

        let button = try sut.inspect().find {
            (try? $0.accessibilityIdentifier()) == "login.button"
        }
        XCTAssertFalse(try button.isDisabled())
    }

    // El mensaje de error debe mostrar exactamente el texto que viene del ViewModel.
    func testErrorMessage_showsCorrectText() throws {
        let expectedError = "Please enter your email"
        let vm = LoginViewModel(repository: MockLoginRepository(result: .success("token")))
        vm.errorMessage = expectedError

        let sut = LoginView(viewModel: vm)

        let errorLabel = try sut.inspect().find {
            (try? $0.accessibilityIdentifier()) == "login.error.message"
        }
        XCTAssertEqual(try errorLabel.text().string(), expectedError)
    }

    // Sin errorMessage el elemento no debe existir en el árbol de vistas.
    func testErrorMessage_isHidden_whenNoError() throws {
        let vm = LoginViewModel(repository: MockLoginRepository(result: .success("token")))

        let sut = LoginView(viewModel: vm)

        let errorLabel = try? sut.inspect().find {
            (try? $0.accessibilityIdentifier()) == "login.error.message"
        }
        XCTAssertNil(errorLabel)
    }
}
