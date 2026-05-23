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
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }
    
    public var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                VStack(
                    spacing: 40
                ) {
                    Text(
                        String(
                            localized: "Login.AppName"
                        )
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top)
                    
                    VStack(
                        spacing: 20
                    ) {
                        VStack(
                            spacing: 8
                        ) {
                            Text(
                                String(
                                    localized:
                                        "Login.Title"
                                )
                            )
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            
                            
                            Text(
                                String(
                                    localized:
                                        "Login.Subtitle"
                                )
                            )
                            .foregroundColor(
                                .gray
                            )
                        }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            Text(
                                String(
                                    localized:
                                        "Login.EmailTitle"
                                )
                            )
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            HStack {
                                
                                Image(
                                    systemName:
                                        "envelope"
                                )
                                .foregroundColor(
                                    .gray
                                )
                                
                                
                                TextField(
                                    String(
                                        localized:
                                            "Login.EmailPlaceholder"
                                    ),
                                    text:
                                        $viewModel.email
                                )
                                .keyboardType(
                                    .emailAddress
                                )
                                .textInputAutocapitalization(
                                    .never
                                )
                                .autocorrectionDisabled()
                                .foregroundColor(
                                    .white
                                )
                            }
                            .padding()
                            .background(
                                Color.black.opacity(
                                    0.6
                                )
                            )
                            .cornerRadius(
                                12
                            )
                        }
                        
                        VStack(
                            alignment:
                                    .leading,
                            spacing: 8
                        ) {
                            Text(
                                String(
                                    localized:
                                        "Login.PasswordTitle"
                                )
                            )
                            .font(
                                .caption
                            )
                            .foregroundColor(
                                .gray
                            )
                            
                            HStack {
                                Image(
                                    systemName:
                                        "lock"
                                )
                                .foregroundColor(
                                    .gray
                                )
                                
                                Group {
                                    if showPassword {
                                        TextField(
                                            String(
                                                localized:
                                                    "Login.PasswordPlaceholder"
                                            ),
                                            text:
                                                $viewModel.password
                                        )
                                        
                                    } else {
                                        SecureField(
                                            String(
                                                localized:
                                                    "Login.PasswordPlaceholder"
                                            ),
                                            text:
                                                $viewModel.password
                                        )
                                    }
                                }
                                .foregroundColor(
                                    .white
                                )
                                
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(
                                        systemName:
                                            showPassword ?
                                        "eye.slash":
                                            "eye"
                                    )
                                    .foregroundColor(
                                        .gray
                                    )
                                }
                            }
                            .padding()
                            .background(
                                Color.black.opacity(
                                    0.6
                                )
                            )
                            .cornerRadius(
                                12
                            )
                        }
                        
                        Button {
                            viewModel.login()
                        } label: {
                            
                            if viewModel.isLoading {
                                
                                ProgressView()
                                    .tint(
                                        .white
                                    )
                                
                            } else {
                                
                                Text(
                                    String(
                                        localized:
                                            "Login.Button"
                                    )
                                )
                                .fontWeight(
                                    .bold
                                )
                                .foregroundColor(
                                    .white
                                )
                            }
                        }
                        .frame(
                            maxWidth:
                                    .infinity
                        )
                        .frame(
                            height: 55
                        )
                        .background(
                            Color.blue
                        )
                        .cornerRadius(
                            15
                        )
                        .disabled(
                            viewModel.isLoading
                        )
                        
                        if let error =
                            viewModel.errorMessage {
                            
                            Text(
                                error
                            )
                            .foregroundColor(
                                .red
                            )
                            .font(
                                .caption
                            )
                        }
                        
                        Button {
                            
                        } label: {
                            
                            Text(
                                String(
                                    localized:
                                        "Login.ForgotPassword"
                                )
                            )
                            .foregroundColor(
                                .blue
                            )
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(
                            cornerRadius:
                                25
                        )
                        .fill(
                            Color.white.opacity(
                                0.05
                            )
                        )
                    )
                    .padding(
                        .horizontal
                    )
                    
                    HStack {
                        
                        Text(
                            String(
                                localized:
                                    "Login.AccountQuestion"
                            )
                        )
                        .foregroundColor(
                            .gray
                        )
                        
                        Button {
                            
                        } label: {
                            
                            Text(
                                String(
                                    localized:
                                        "Login.Register"
                                )
                            )
                            .foregroundColor(
                                .blue
                            )
                        }
                    }
                }
            }
        }
        .onChange(
            of: viewModel.token
        ) { token in
            
            if !token.isEmpty {
                showSuccessAlert =
                true
            }
        }
        .alert(
            String(
                localized:
                    "Login.SuccessTitle"
            ),
            isPresented:
                $showSuccessAlert
        ) {
            Button(
                "OK"
            ) {}
        } message: {
            Text(
                String(
                    localized:
                        "Login.SuccessMessage"
                )
            )
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
