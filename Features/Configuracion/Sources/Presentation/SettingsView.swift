//
//  SettingsView.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 25/06/26.
//

import Foundation

import SwiftUI

public struct SettingsView: View {
    
    @StateObject private var viewModel: SettingsViewModel
    private let onLogout: () -> Void
    //Thema
    private let onThemeChange: (AppTheme) -> Void
    
    public init(
        viewModel: SettingsViewModel,
        onLogout: @escaping () -> Void,
        onThemeChange: @escaping (AppTheme) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onLogout = onLogout
        self.onThemeChange = onThemeChange
    }
    
    public var body: some View {
        Form {
            Picker("Moneda Base", selection: Binding(
                get: {viewModel.currency},
                set: {viewModel.updateCurrency($0)})) {
                    ForEach(Settings.allCases, id: \.self) { currency in
                        Text(currency.rawValue)
                            .tag(currency)
                    }
                }
            
            Picker("Tema", selection: Binding(
                get: { viewModel.theme },
                set: {
                    viewModel.updateTheme($0)
                    onThemeChange($0)
                }
            )) {
                ForEach(AppTheme.allCases, id: \.self) { theme in
                    Text(theme.rawValue)
                        .tag(theme)
                }
            }
            
            Toggle(
                "Notificaciones",
                isOn: Binding(
                    get: {
                        viewModel.notificationsEnabled
                    },
                    set: {
                        viewModel.updateNotifications($0)
                    }
                )
            )
            
            Button("Cerrar Sesión") {
                viewModel.logout()
                onLogout()
            }
        }
        .task {
            viewModel.load()
        }
    }
}
