//
//  CryptoRadarApp.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/05/26.
//

import SwiftUI
import CoreData
import Swinject
import Login
import Register

@main
struct CryptoRadarApp: App {
    let container: Container = {
        
        let assembler = Assembler([
            RegisterAssembly(),
            LoginAssembly()
        ])
        return assembler.resolver as! Container
        
    }()
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: container.resolve(LoginViewModel.self)!)
            /*RegisterView(
                viewModel:
                    container.resolve(
                        RegisterViewModel.self
                    )!
            )*/
        }
    }
}
