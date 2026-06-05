import SwiftUI
import Swinject
import Login
import Register
import StorageKit
import CryptoList

@main
struct CryptoRadarApp: App {
    
    @StateObject private var appRootManager: AppRootManager = {
        
        let manager = AppRootManager()
        
        // KeyChainManager
        if KeychainManager.shared.getToken() != nil {
            manager.currentRoot = .principal
        }
        return manager
    }()
    
    let container: Container = {
        let assembler = Assembler([
            RegisterAssembly(),
            LoginAssembly(),
            CryptoListAssembly()
        ])
        return assembler.resolver
        as! Container
        
    }()
    
    var body: some Scene {
        WindowGroup {
            switch appRootManager.currentRoot {
            case .authentication:
                
                AuthenticationRootView(
                    loginViewModel:
                        container.resolve(
                            LoginViewModel.self
                        )!,
                    registerViewModel:
                        container.resolve(
                            RegisterViewModel.self
                        )!
                )
            case .principal:
                CryptoListView(viewModel:container.resolve(CryptoListViewModel.self)!)
            }
        }
        .environmentObject(
            appRootManager
        )
    }
}
