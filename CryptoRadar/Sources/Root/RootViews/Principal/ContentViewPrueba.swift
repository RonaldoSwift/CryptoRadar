//
//  Content.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 27/05/26.
//

import SwiftUI

struct ContentViewPrueba: View {
    @EnvironmentObject var appRootManager: AppRootManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Pantalla Principal")
                .font(.largeTitle)
            Button {
                KeychainManager.shared.deleteToken()
                appRootManager.currentRoot = .authentication
            } label: {
                Text("Cerrar sesión")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.red)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentViewPrueba()
}
