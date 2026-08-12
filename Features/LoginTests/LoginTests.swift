//
//  LoginTests.swift
//  LoginTests
//
//  Created by Ronaldo Andre on 22/05/26.
//

import XCTest
import Testing
import Foundation
@testable import Login

final class LoginTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Mocks
    final class MockLoginRepository: LoginRepositoryProtocol {
        
        var result: Result<String, Error>
        
        init(result: Result<String, Error>) {
            self.result = result
        }
        
        func login(email: String, password: String) async throws -> String {
            try result.get()
        }
    }
    
    enum LoginMockError: LocalizedError {
        case loginFailed
        var errorDescription: String? { "Login Failed"}
        
    }
    
    final class MockAuthService: AuthServiceLoginProtocol {
        var result: Result<LoginResponse, Error>
        
        init(result: Result<LoginResponse, Error>) {
            self.result = result
        }
        
        func login(email: String, password: String) async throws -> LoginResponse {
            try result.get()
        }
    }
    
    //LoginViewModelTest
    
    @Suite("LoginViewModel")
    @MainActor
    struct LoginViewModelTests {
        
        @Test("Empty email sets error message")
        func emptyEmail_setsErrorMessage() async {
            let vm = LoginViewModel(repository: MockLoginRepository(result: .success("token")))
            vm.email = ""
            vm.password = "password123"
            
            await vm.login()
            
            #expect(vm.errorMessage != nil)
            #expect(!vm.isLoading)
        }
        
        @Test("Invalid email sets error message")
        func invalidEmail_setsErrorMessage() async {
            let vm = LoginViewModel(repository: MockLoginRepository(result: .success("token")))
            vm.email = "not-an-email"
            vm.password = "password123"
            
            await vm.login()
            
            #expect(vm.errorMessage != nil)
            #expect(!vm.isLoading)
        }
        
        //Password Validation
        
        @Test("Empty password sets error message")
        func emptyPassword_setsErrorMessage() async {
            let vm = LoginViewModel(repository: MockLoginRepository(result: .success("token")))
            vm.email = "user@example.com"
            vm.password = ""
            
            await vm.login()
            
            #expect(vm.errorMessage != nil)
            #expect(!vm.isLoading)
        }
        
        @Test("Password too short sets error message")
        func passwordTooShort_setsErrorMessage() async {
            let vm = LoginViewModel(repository: MockLoginRepository(result: .success("token")))
            vm.email = "user@example.com"
            vm.password = "123"
            
            await vm.login()
            
            #expect(vm.errorMessage != nil)
            #expect(!vm.isLoading)
        }
        
        //Login
        
        @Test("Valid credentials sets token and shows alert")
        func validCredentials_setsTokenAndShowsAlert() async {
            let expectedToken = "token_abc123"
            let vm = LoginViewModel(repository: MockLoginRepository(result: .success(expectedToken)))
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
                repository: MockLoginRepository(result: .failure(LoginMockError.loginFailed))
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
    
    // LoginRepositoryImplTests
    @Suite("LoginRepositoryImpl")
    struct LoginRepositoryImplTests {
        
        @Test("Service success returns token")
        func serviceSuccess_returnsToken() async throws {
            let expectedToken = "response_token"
            let service = MockAuthService(result: .success(LoginResponse(token: expectedToken)))
            let repository = LoginRepositoryImpl(service: service)
            
            let token = try await repository.login(
                email: "user@example.com",
                password: "password123"
            )
            #expect(token == expectedToken)
        }
        
        @Test("Service failure throws error")
        func serviceFailure_throwsError() async {
            let service = MockAuthService(result: .failure(LoginMockError.loginFailed))
            let repository = LoginRepositoryImpl(service: service)
            
            await #expect(throws: LoginMockError.self) {
                _ = try await repository.login(
                    email: "user@example.com",
                    password: "password123"
                )
            }
        }
    }
}
