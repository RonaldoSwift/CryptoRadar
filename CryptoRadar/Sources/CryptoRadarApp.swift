import SwiftUI
import Swinject
import Login
import Register
import StorageKit
import CryptoList
import Detalle
import Favorite
import SwiftData
import Configuracion

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
            DetalleAssembly(),
            FavoriteAssembly(),
            SettingsAssembly()
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
                TabView {
                    NavigationStack {
                        CryptoListView(
                            viewModel: container.resolve(CryptoListViewModel.self)!,
                            favoriteViewModel: container.resolve(FavoriteListViewModel.self)!
                        ) { cryptoId in
                            selectedCrypto = CryptoSelection(id: cryptoId)
                        }
                        .navigationDestination(item: $selectedCrypto) { crypto in
                            CryptoDetailView(
                                cryptoId: crypto.id,
                                viewModel: container.resolve(CryptoDetailViewModel.self)!
                            )
                        }
                    }
                    .tabItem {
                        Label(AppStrings.market, image: AppImages.searchList)
                    }
                    
                    NavigationStack {
                        FavoriteListView(viewModel: container.resolve(FavoriteListViewModel.self)!) { cryptoId in
                            selectedCrypto = CryptoSelection(id:cryptoId)
                        }
                        .navigationDestination(item: $selectedCrypto) { crypto in
                            CryptoDetailView(
                                cryptoId: crypto.id,
                                viewModel: container.resolve(CryptoDetailViewModel.self)!
                            )
                        }
                    }
                    .tabItem {
                        Label(AppStrings.favorite,systemImage: AppImages.favorite)
                    }
                    
                    NavigationStack {
                        SettingsView(viewModel: container.resolve(SettingsViewModel.self)!)
                    }
                    .tabItem {
                        Label(AppStrings.settings,systemImage: AppImages.settingsConfiguracion)
                    }
                }
            }
        }
        .environmentObject(
            appRootManager
        )
        .modelContainer(
            for: [FavoriteCryptoEntity.self]
        )
    }
}

private struct CryptoSelection: Identifiable, Hashable {
    let id: String
}
