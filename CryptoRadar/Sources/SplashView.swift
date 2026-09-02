//
//  SplashView.swift
//  Configuracion
//
//  Created by Ronaldo Andre on 2/09/26.
//

import Foundation
import SwiftUI
import StorageKit

struct SplashView: View {

    @EnvironmentObject private var appRootManager: AppRootManager

    var body: some View {
        ZStack {
            Color("LaunchBackground")
                .ignoresSafeArea()

            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                if KeychainManager.shared.getToken() != nil {
                    appRootManager.currentRoot = .principal
                } else {
                    appRootManager.currentRoot = .authentication
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(AppRootManager())
}
