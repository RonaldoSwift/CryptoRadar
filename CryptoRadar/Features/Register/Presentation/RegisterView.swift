//
//  RegisterView.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/05/26.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel: RegisterViewModel
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var showSuccessAlert = false
    
    init(
        viewModel: RegisterViewModel
    ) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing:40) {
                    Text(
                        Strings.Register.appName
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top)
                    
                    VStack(spacing:20) {
                        VStack(spacing:8) {
                            Text(
                                Strings.Register.title
                            )
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            
                            Text(
                                Strings.Register.subtitle
                            )
                            .foregroundColor(.gray)
                        }
                        
                        VStack(
                            alignment:.leading,
                            spacing:8
                        ) {
                            Text(
                                Strings.Register.emailTitle
                            )
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            HStack {
                                Image(
                                    systemName: "envelope"
                                )
                                .foregroundColor(.gray)
                                
                                TextField(
                                    Strings.Register.emailPlaceholder,
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
                            alignment:.leading,
                            spacing:8
                        ) {
                            Text(
                                Strings.Register.passwordTitle
                            )
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName:"lock")
                                    .foregroundColor(.gray)
                                
                                Group {
                                    if showPassword {
                                        TextField(
                                            Strings.Register.passwordPlaceholder,
                                            text: $viewModel.password
                                        )
                                        
                                    } else {
                                        SecureField(
                                            Strings.Register.passwordPlaceholder,
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
                                        "eye.slash":
                                            "eye"
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
                            alignment:.leading,
                            spacing:8
                        ) {
                            Text(
                                Strings.Register.confirmPasswordTitle
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
                                            Strings.Register.confirmPasswordPlaceholder,
                                            text: $viewModel.confirmPassword
                                        )
                                        
                                    } else {
                                        SecureField(
                                            Strings.Register.confirmPasswordPlaceholder,
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
                                        "eye.slash":
                                            "eye"
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
                                
                                Text(
                                    Strings.Register.createButton
                                )
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            }
                        }
                        .frame(
                            maxWidth:.infinity
                        )
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
                        
                        
                        Text(
                            Strings.Register.terms
                        )
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(
                            cornerRadius:25
                        )
                        .fill(
                            Color.white.opacity(0.05)
                        )
                    )
                    .padding(.horizontal)
                    
                    HStack {
                        Text(
                            Strings.Register.accountQuestion
                        )
                        .foregroundColor(.gray)
                        
                        Button {
                            
                        } label: {
                            Text(
                                Strings.Register.login
                            )
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
            Strings.Register.successTitle,
            isPresented: $showSuccessAlert
        ) {
            Button("OK") {}
        } message: {
            Text(
                Strings.Register.successMessage
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
