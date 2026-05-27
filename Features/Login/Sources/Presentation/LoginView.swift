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
    @State private var showSuccessAlert = false
    
    public init(
        viewModel: LoginViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    Text(LoginStrings.appName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top)
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text(LoginStrings.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text(LoginStrings.subtitle)
                                .foregroundColor(.gray)
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text(LoginStrings.emailTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                
                                TextField(
                                    LoginStrings.emailPlaceholder,
                                    text: $viewModel.email
                                )
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .foregroundColor(.white)
                            }
                            .padding()
                            .background(
                                Color.black.opacity(0.6)
                            )
                            .cornerRadius(12)
                        }
                        
                        
                        VStack(alignment: .leading,spacing: 8) {
                            Text(LoginStrings.passwordTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                
                                Group {
                                    if showPassword {
                                        TextField(
                                            LoginStrings.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                    } else {
                                        SecureField(
                                            LoginStrings.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                    }
                                }
                                .foregroundColor(.white)
                                
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
                            .background(
                                Color.black.opacity(0.6)
                            )
                            .cornerRadius(12)
                        }
                        
                        Button {
                            viewModel.login()
                        } label: {
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text(LoginStrings.button)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .disabled(viewModel.isLoading)
                        
                        
                        if let error =
                            viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        
                        Button {
                            
                        } label: {
                            Text(LoginStrings.forgotPassword)
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
                        Text(LoginStrings.accountQuestion)
                            .foregroundColor(.gray)
                        
                        Button {
                            
                        } label: {
                            Text(LoginStrings.register)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .onChange(
            of: viewModel.token
        ) { token in
            
            if !token.isEmpty {
                showSuccessAlert = true
            }
        }
        .alert(
            LoginStrings.successTitle,
            isPresented:$showSuccessAlert
        ) {
            
            Button("OK") {}
        } message: {
            Text(LoginStrings.successMessage)
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
