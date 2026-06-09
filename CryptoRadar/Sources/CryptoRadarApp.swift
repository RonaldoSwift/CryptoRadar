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
    
    @State private var selectedCrypto: String?
    
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
                    CryptoListView(viewModel:container.resolve(CryptoListViewModel.self)!) { cryptoId in
                        selectedCrypto = cryptoId
                    }.navigationDestination(item:$selectedCrypto) { id in
                        CryptoDetailV(
                            cryptoId: id,
                            viewModel:container.resolve(CryptoDetailViewModel.self)!
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

extension String: Identifiable {
    
    public var id: String {
        self
    }
}
