import SwiftUI
import Swinject
import Login
import Register
import StorageKit
import CryptoList
import Detalle

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
    
    @State private var selectedCrypto: CryptoSelection?
    
    let container: Container = {
        let assembler = Assembler([
            RegisterAssembly(),
            LoginAssembly(),
            CryptoListAssembly(),
            DetalleAssembly()
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
                NavigationStack {
                    CryptoListView(viewModel:container.resolve(CryptoListViewModel.self)!
                    ) { cryptoId in
                        selectedCrypto = CryptoSelection(id: cryptoId)
                    }
                    .navigationDestination(item: $selectedCrypto) { crypto in
                        CryptoDetailView(
                            cryptoId: crypto.id,
                            viewModel:container.resolve(
                                CryptoDetailViewModel.self
                            )!
                        )
                    }
                }
            }
        }
        .environmentObject(
            appRootManager
        )
    }
}

private struct CryptoSelection: Identifiable, Hashable {
    let id: String
}
