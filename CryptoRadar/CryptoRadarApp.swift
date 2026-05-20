//
//  CryptoRadarApp.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/05/26.
//

import SwiftUI
import CoreData
import Swinject

@main
struct CryptoRadarApp: App {
    let container: Container = {
        
        let assembler = Assembler([
            RegisterAssembly()
        ])
        return assembler.resolver as! Container
        
    }()
    var body: some Scene {
        WindowGroup {
            RegisterView(
                viewModel:
                    container.resolve(
                        RegisterViewModel.self
                    )!
            )
        }
    }
}
