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
            Color(.systemBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing:10) {
                    Text(RegisterStrings.Register.appName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top)
                    
                    VStack(spacing:20) {
                        VStack(spacing:8) {
                            Text(RegisterStrings.Register.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text(RegisterStrings.Register.subtitle)
                                .foregroundColor(.gray)
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text(RegisterStrings.Register.nameTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                
                                Image(systemName: "person")
                                    .foregroundColor(.gray)
                                
                                TextField(
                                    RegisterStrings.Register.namePlaceholder,
                                    text: $viewModel.name
                                )
                                .textInputAutocapitalization(.words)
                                .foregroundColor(.primary)
                            }
                            .padding()
                            .background((Color(.systemGray6)))
                            .cornerRadius(12)
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text(RegisterStrings.Register.emailTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(
                                    systemName: "envelope"
                                )
                                .foregroundColor(.gray)
                                
                                TextField(
                                    RegisterStrings.Register.emailPlaceholder,
                                    text: $viewModel.email
                                )
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .foregroundColor(.primary)
                            }
                            .padding()
                            .background((Color(.systemGray6)))
                            .cornerRadius(12)
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            Text(RegisterStrings.Register.passwordTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName:"lock")
                                    .foregroundColor(.gray)
                                
                                Group {
                                    if showPassword {
                                        TextField(
                                            RegisterStrings.Register.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                        
                                    } else {
                                        SecureField(
                                            RegisterStrings.Register.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                    }
                                }
                                .foregroundColor(.gray)
                                
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
                            .background((Color(.systemGray6)))
                            .cornerRadius(12)
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text(RegisterStrings.Register.confirmPasswordTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName:"shield")
                                    .foregroundColor(.gray)
                                
                                Group {
                                    
                                    if showConfirmPassword {
                                        TextField(
                                            RegisterStrings.Register.confirmPasswordPlaceholder,
                                            text: $viewModel.confirmPassword
                                        )
                                        
                                    } else {
                                        SecureField(
                                            RegisterStrings.Register.confirmPasswordPlaceholder,
                                            text: $viewModel.confirmPassword
                                        )
                                    }
                                }
                                .foregroundColor(.gray)
                                
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
                            .background((Color(.systemGray6)))
                            .cornerRadius(12)
                        }
                        
                        Button {
                            viewModel.register()
                        } label: {
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text(RegisterStrings.Register.createButton)
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
                        Text(RegisterStrings.Register.terms)
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
                        Text(RegisterStrings.Register.accountQuestion)
                            .foregroundColor(.gray)
                        
                        Button {
                            onLoginTap?()
                        } label: {
                            Text(RegisterStrings.Register.login)
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
