//
//  RegisterView.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 20/05/26.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel: RegisterViewModel
    @State private var confirmPassword = ""
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
                    Text("CryptoRadar")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top)
                    
                    VStack(spacing:20) {
                        VStack(spacing:8) {
                            Text("Create Account")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text(
                                "Start your financial journey with us"
                            )
                            .foregroundColor(.gray)
                        }
                        
                        
                        VStack(alignment:.leading,spacing:8) {
                            
                            Text("EMAIL ADDRESS")
                                .font(.caption)
                                .foregroundColor(.gray)
                            HStack {
                                Image(
                                    systemName: "envelope"
                                )
                                .foregroundColor(.gray)
                                
                                TextField(
                                    "name@example.com",
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
                        
                        
                        VStack(alignment:.leading,spacing:8) {
                            Text("PASSWORD")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName:"lock")
                                    .foregroundColor(.gray)
                                
                                Group {
                                    if showPassword {
                                        TextField(
                                            "Min. 8 characters",
                                            text: $viewModel.password
                                        )
                                        
                                    } else {
                                        SecureField(
                                            "Min. 8 characters",
                                            text: $viewModel.password
                                        )
                                    }
                                }
                                .foregroundColor(.white)
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(
                                        systemName: showPassword ?
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
                        
                        VStack(alignment:.leading,spacing:8) {
                            Text("CONFIRM PASSWORD")
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
                                            "Repeat your password",
                                            text: $confirmPassword
                                        )
                                    } else {
                                        SecureField(
                                            "Repeat your password",
                                            text: $confirmPassword
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
                                        "eye.slash":"eye"
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
                            guard viewModel.password ==
                                    confirmPassword
                            else {
                                viewModel.errorMessage =
                                "Passwords don't match"
                                return
                            }
                            
                            viewModel.register()
                        } label: {
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text(
                                    "Create Account"
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
                            "By creating an account, you agree to our Terms of Service and Privacy Policy."
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
                            Color.white.opacity(
                                0.05
                            )
                        )
                    )
                    .padding(.horizontal)
                    
                    
                    HStack {
                        Text(
                            "Already have an account?"
                        )
                        .foregroundColor(.gray)
                        Button {
                            
                        } label: {
                            Text("Log In")
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
            "Success",
            isPresented: $showSuccessAlert
        ) {
            Button("OK") { }
        } message: {
            Text(
                "Account created successfully"
            )
        }
    }
}

#Preview {
    RegisterView(
        viewModel:
            RegisterViewModel(
                repository:
                    RegisterRepositoryImpl(
                        service:
                            AuthServiceRegister()
                    )
            )
    )
}
