//
//  LoginViewModelTests.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 17/08/26.
//

import Foundation
import Testing
@testable import Login

@Suite("LoginViewModel")
@MainActor
struct LoginViewModelTests {

    @Test("Empty email sets error message")
    func emptyEmail_setsErrorMessage() async {
        let vm = LoginViewModel(
            repository: MockLoginRepository(result: .success("token"))
        )

        vm.email = ""
        vm.password = "password123"

        await vm.login()

        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }

    @Test("Invalid email sets error message")
    func invalidEmail_setsErrorMessage() async {
        let vm = LoginViewModel(
            repository: MockLoginRepository(result: .success("token"))
        )

        vm.email = "not-an-email"
        vm.password = "password123"

        await vm.login()

        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }

    @Test("Empty password sets error message")
    func emptyPassword_setsErrorMessage() async {
        let vm = LoginViewModel(
            repository: MockLoginRepository(result: .success("token"))
        )

        vm.email = "user@example.com"
        vm.password = ""

        await vm.login()

        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }

    @Test("Password too short sets error message")
    func passwordTooShort_setsErrorMessage() async {
        let vm = LoginViewModel(
            repository: MockLoginRepository(result: .success("token"))
        )

        vm.email = "user@example.com"
        vm.password = "123"

        await vm.login()

        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }

    @Test("Valid credentials sets token and shows alert")
    func validCredentials_setsTokenAndShowsAlert() async {
        let expectedToken = "token_abc123"

        let vm = LoginViewModel(
            repository: MockLoginRepository(
                result: .success(expectedToken)
            )
        )

        vm.email = "user@example.com"
        vm.password = "password123"

        await vm.login()

        #expect(vm.token == expectedToken)
        #expect(vm.showSuccessAlert)
        #expect(vm.errorMessage == nil)
        #expect(!vm.isLoading)
    }

    @Test("Repository failure sets error message")
    func repositoryFailure_setsErrorMessage() async {
        let vm = LoginViewModel(
            repository: MockLoginRepository(
                result: .failure(LoginMockError.loginFailed)
            )
        )

        vm.email = "user@example.com"
        vm.password = "password123"

        await vm.login()

        #expect(vm.errorMessage != nil)
        #expect(!vm.showSuccessAlert)
        #expect(vm.token.isEmpty)
        #expect(!vm.isLoading)
    }
}
