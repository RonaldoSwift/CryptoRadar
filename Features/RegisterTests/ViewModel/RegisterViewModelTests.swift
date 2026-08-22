//
//  RegisterViewModelTests.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 17/08/26.
//

import Foundation
import Testing
@testable import Register

@Suite("RegisterViewModel")
@MainActor
struct RegisterViewModelTests {
    
    @Test("Empty name sets error message")
    func emptyName_setsErrorMessage() async {
        let vm = RegisterViewModel(
            repository: MockRegisterRepository(
                result: .success("token")
            )
        )
        
        vm.name = ""
        vm.email = "user@example.com"
        vm.password = "password123"
        vm.confirmPassword = "password123"
        
        vm.register()
        
        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }
    
    @Test("Empty email sets error message")
    func emptyEmail_setsErrorMessage() async {
        let vm = RegisterViewModel(
            repository: MockRegisterRepository(
                result: .success("token")
            )
        )
        
        vm.name = "Ronaldo"
        vm.email = ""
        vm.password = "password123"
        vm.confirmPassword = "password123"
        
        vm.register()
        
        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }
    
    @Test("Invalid email sets error message")
    func invalidEmail_setsErrorMessage() async {
        let vm = RegisterViewModel(
            repository: MockRegisterRepository(
                result: .success("token")
            )
        )
        
        vm.name = "Ronaldo"
        vm.email = "invalid-email"
        vm.password = "password123"
        vm.confirmPassword = "password123"
        
        vm.register()
        
        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }
    
    @Test("Empty password sets error message")
    func emptyPassword_setsErrorMessage() async {
        let vm = RegisterViewModel(
            repository: MockRegisterRepository(
                result: .success("token")
            )
        )
        
        vm.name = "Ronaldo"
        vm.email = "user@example.com"
        vm.password = ""
        vm.confirmPassword = ""
        
        vm.register()
        
        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }
    
    @Test("Password too short sets error message")
    func passwordTooShort_setsErrorMessage() async {
        let vm = RegisterViewModel(
            repository: MockRegisterRepository(
                result: .success("token")
            )
        )
        
        vm.name = "Ronaldo"
        vm.email = "user@example.com"
        vm.password = "123"
        vm.confirmPassword = "123"
        
        vm.register()
        
        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }
    
    @Test("Password mismatch sets error message")
    func passwordMismatch_setsErrorMessage() async {
        let vm = RegisterViewModel(
            repository: MockRegisterRepository(
                result: .success("token")
            )
        )
        
        vm.name = "Ronaldo"
        vm.email = "user@example.com"
        vm.password = "password123"
        vm.confirmPassword = "different123"
        
        vm.register()
        
        #expect(vm.errorMessage != nil)
        #expect(!vm.isLoading)
    }
    
    @Test("Valid credentials set token")
    func validCredentials_setsToken() async {
        let expectedToken = "token_abc123"
        
        let vm = RegisterViewModel(
            repository: MockRegisterRepository(
                result: .success(expectedToken)
            )
        )
        
        vm.name = "Ronaldo"
        vm.email = "user@example.com"
        vm.password = "password123"
        vm.confirmPassword = "password123"
        
        vm.register()
        
        // register() launches an internal Task.
        try? await Task.sleep(for: .milliseconds(100))
        
        #expect(vm.token == expectedToken)
        #expect(vm.errorMessage == nil)
        #expect(!vm.isLoading)
    }
    
    @Test("Repository failure sets error message")
    func repositoryFailure_setsErrorMessage() async {
        let vm = RegisterViewModel(
            repository: MockRegisterRepository(
                result: .failure(RegisterMockError.registerFailed)
            )
        )
        
        vm.name = "Ronaldo"
        vm.email = "user@example.com"
        vm.password = "password123"
        vm.confirmPassword = "password123"
        
        vm.register()
        
        try? await Task.sleep(for: .milliseconds(100))
        
        #expect(vm.errorMessage != nil)
        #expect(vm.token.isEmpty)
        #expect(!vm.isLoading)
    }
}
