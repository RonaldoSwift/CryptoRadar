//
//  Register.swift
//  Register
//
//  Created by Ronaldo Andre on 21/05/26.
//

import Foundation
import SwiftUI

public struct RegisterView: View {
    
    @StateObject private var viewModel: RegisterViewModel
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var showSuccessAlert = false
    
    let onRegisterSuccess: (() -> Void)?
    let onLoginTap: (() -> Void)?
    
    public init(
        viewModel: RegisterViewModel,
        onRegisterSuccess: (() -> Void)? = nil,
        onLoginTap: (() -> Void)? = nil
    ) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
        self.onRegisterSuccess = onRegisterSuccess
        self.onLoginTap = onLoginTap
    }
    
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing:40) {
                    Text(RegisterStrings.appName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top)
                    
                    VStack(spacing:20) {
                        VStack(spacing:8) {
                            Text(RegisterStrings.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text(RegisterStrings.subtitle)
                                .foregroundColor(.gray)
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text(RegisterStrings.nameTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                
                                Image(systemName: "person")
                                    .foregroundColor(.gray)
                                
                                TextField(
                                    RegisterStrings.namePlaceholder,
                                    text: $viewModel.name
                                )
                                .textInputAutocapitalization(.words)
                                .foregroundColor(.white)
                            }
                            .padding()
                            .background(
                                Color.black.opacity(0.6)
                            )
                            .cornerRadius(12)
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text(RegisterStrings.emailTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(
                                    systemName: "envelope"
                                )
                                .foregroundColor(.gray)
                                
                                TextField(
                                    RegisterStrings.emailPlaceholder,
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
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            Text(RegisterStrings.passwordTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName:"lock")
                                    .foregroundColor(.gray)
                                
                                Group {
                                    if showPassword {
                                        TextField(
                                            RegisterStrings.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                        
                                    } else {
                                        SecureField(
                                            RegisterStrings.passwordPlaceholder,
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
                                        "eye.slash" : "eye"
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
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text(RegisterStrings.confirmPasswordTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName:"shield")
                                    .foregroundColor(.gray)
                                
                                Group {
                                    
                                    if showConfirmPassword {
                                        TextField(
                                            RegisterStrings.confirmPasswordPlaceholder,
                                            text: $viewModel.confirmPassword
                                        )
                                        
                                    } else {
                                        SecureField(
                                            RegisterStrings.confirmPasswordPlaceholder,
                                            text: $viewModel.confirmPassword
                                        )
                                    }
                                }
                                .foregroundColor(.white)
                                
                                Button {
                                    showConfirmPassword.toggle()
                                } label: {
                                    
                                    Image(
                                        systemName:
                                            showConfirmPassword ?
                                        "eye.slash" : "eye"
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
                            viewModel.register()
                        } label: {
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text(RegisterStrings.createButton)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height:55)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .disabled(viewModel.isLoading)
                        
                        if let error =
                            viewModel.errorMessage {
                            
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        Text(RegisterStrings.terms)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius:25)
                            .fill(Color.white.opacity(0.05)
                                 )
                    )
                    .padding(.horizontal)
                    
                    HStack {
                        Text(RegisterStrings.accountQuestion)
                            .foregroundColor(.gray)
                        
                        Button {
                            onLoginTap?()
                        } label: {
                            Text(RegisterStrings.login)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .onChange(of: viewModel.token) { token in
            if !token.isEmpty {
                onRegisterSuccess?()
            }
        }
        .alert(String(localized: "Register.SuccessTitle"),
               isPresented: $showSuccessAlert
        ) {
            Button("OK") {
                onRegisterSuccess?()
            }
        } message: {
            Text(
                String(localized: "Register.SuccessMessage")
            )
        }
    }
}

#Preview {
    
    RegisterView(
        viewModel:
            RegisterViewModel(
                repository:
                    MockRegisterRepository()
            )
    )
}
