//
//  Login.swift
//  Login
//
//  Created by Ronaldo Andre on 22/05/26.
//

import Foundation
import SwiftUI

public struct LoginView: View {
    
    @StateObject private var viewModel: LoginViewModel
    @State private var showPassword = false
    
    let onLoginSuccess: (() -> Void)?
    let onRegisterTap: (() -> Void)?
    
    public init(
        viewModel: LoginViewModel,
        onLoginSuccess: (() -> Void)? = nil,
        onRegisterTap: (() -> Void)? = nil
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onLoginSuccess = onLoginSuccess
        self.onRegisterTap = onRegisterTap
    }
    
    public var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    Text(LoginStrings.Login.appName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top)
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text(LoginStrings.Login.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text(LoginStrings.Login.subtitle)
                                .foregroundColor(.gray)
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text(LoginStrings.Login.emailTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                
                                TextField(
                                    LoginStrings.Login.emailPlaceholder,
                                    text: $viewModel.email
                                )
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .foregroundColor(.primary)
                                .accessibilityIdentifier("login.email.textfield")
                            }
                            .padding()
                            .background((Color(.systemGray6)))
                            .cornerRadius(12)
                        }
                        
                        
                        VStack(alignment: .leading,spacing: 8) {
                            Text(LoginStrings.Login.passwordTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                
                                Group {
                                    if showPassword {
                                        TextField(
                                            LoginStrings.Login.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                        //ponerle un identificador único al SecureField
                                        .accessibilityIdentifier("login.password.textfield")
                                    } else {
                                        SecureField(
                                            LoginStrings.Login.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                        .accessibilityIdentifier("login.password.textfield")
                                    }
                                }
                                .foregroundColor(.primary)
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(
                                        systemName:showPassword ?
                                        "eye.slash": "eye"
                                    )
                                    .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        Button {
                            Task { await viewModel.login() }
                        } label: {
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text(LoginStrings.Login.button)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .disabled(viewModel.isLoading)
                        .accessibilityIdentifier("login.button")
                        
                        if let error =
                            viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                                .accessibilityIdentifier("login.error.message")
                        }
                        
                        Button {
                            
                        } label: {
                            Text(LoginStrings.Login.forgotPassword)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white.opacity(0.05)
                             )
                    )
                    .padding(.horizontal)
                    
                    HStack {
                        Text(LoginStrings.Login.accountQuestion)
                            .foregroundColor(.gray)
                        
                        Button {
                            onRegisterTap?()
                        } label: {
                            Text(LoginStrings.Login.register)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .alert(
            LoginStrings.Login.successTitle,
            isPresented:$viewModel.showSuccessAlert
        ) {
            
            Button("OK") {
                onLoginSuccess?()
            }
        } message: {
            Text(LoginStrings.Login.successMessage)
        }
    }
}

#Preview {
    
    LoginView(
        viewModel:
            LoginViewModel(
                repository:
                    MockLoginRepository()
            )
    )
}
