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
    
    public init(
        viewModel: RegisterViewModel
    ) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }
    
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing:40) {
                    Text("Register.AppName")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top)
                    
                    VStack(spacing:20) {
                        VStack(spacing:8) {
                            Text("Register.Title")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Register.Subtitle")
                                .foregroundColor(.gray)
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text("Register.EmailTitle")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(
                                    systemName: "envelope"
                                )
                                .foregroundColor(.gray)
                                
                                TextField(
                                    String(
                                        localized: "Register.EmailPlaceholder"
                                    ),
                                    text: $viewModel.email
                                )
                                .keyboardType(
                                    .emailAddress
                                )
                                .textInputAutocapitalization(
                                    .never
                                )
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
                            Text("Register.PasswordTitle")
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName:"lock")
                                .foregroundColor(.gray)
                                
                                Group {
                                    if showPassword {
                                        TextField(
                                            String(localized:"Register.PasswordPlaceholder"
                                                  ),
                                            text: $viewModel.password
                                        )
                                        
                                    } else {
                                        SecureField(
                                            String(localized:"Register.PasswordPlaceholder"
                                                  ),
                                            text: $viewModel.password
                                        )
                                    }
                                }
                                .foregroundColor(.white)
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    
                                    Image(
                                        systemName:
                                            showPassword ?
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
                            Text(
                                "Register.ConfirmPasswordTitle"
                            )
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            HStack {
                                Image(
                                    systemName:"shield"
                                )
                                .foregroundColor(.gray)
                                
                                Group {
                                    if showConfirmPassword {
                                        
                                        TextField(
                                            String(
                                                localized: "Register.ConfirmPasswordPlaceholder"
                                            ),
                                            text: $viewModel.confirmPassword
                                        )
                                        
                                    } else {
                                        
                                        SecureField(
                                            String(
                                                localized: "Register.ConfirmPasswordPlaceholder"
                                            ),
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
                                Text("Register.CreateButton")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height:55)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .disabled(
                            viewModel.isLoading
                        )
                        
                        if let error =
                            viewModel.errorMessage {
                            
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        Text(
                            String(localized: "Register.Terms")
                        )
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
                        Text(
                            String(localized: "Register.AccountQuestion")
                        )
                        .foregroundColor(.gray)
                        
                        Button {
                            
                        } label: {
                            Text("Register.Login")
                            .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .onChange(of: viewModel.token) { token in
            if !token.isEmpty {
                showSuccessAlert = true
            }
        }
        .alert(
            String(
                localized: "Register.SuccessTitle"),
            isPresented: $showSuccessAlert
        ) {
            Button("OK") {}
        } message: {
            Text(
                String(localized: "Register.SuccessMessage"
                )
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
