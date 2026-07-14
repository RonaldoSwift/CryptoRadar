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
    
    public init(viewModel:SettingsViewModel,onLogout: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onLogout = onLogout
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
