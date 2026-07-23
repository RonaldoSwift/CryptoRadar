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
    @State private var selectedTab = 0
    
    let container: Container = {
        let assembler = Assembler([
            RegisterAssembly(),
            LoginAssembly(),
            CryptoListAssembly(),
            DetalleAssembly(),
            FavoriteAssembly(),
            SettingsAssembly()
        ])
        return assembler.resolver as! Container
        
    }()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .authentication:
                    AuthenticationRootView(
                        loginViewModel: container.resolve(LoginViewModel.self)!,
                        registerViewModel: container.resolve(RegisterViewModel.self)!
                    )
                    
                case .principal:
                    TabView(selection: $selectedTab) {
                        NavigationStack {
                            CryptoListView(
                                viewModel: container.resolve(CryptoListViewModel.self)!,
                                favoriteViewModel: container.resolve(FavoriteListViewModel.self)!
                            ) { cryptoId, name in
                                selectedCrypto = CryptoSelection(
                                    id: cryptoId,
                                    name: name
                                )
                            }
                            .navigationDestination(item: $selectedCrypto) { crypto in
                                CryptoDetailView(
                                    cryptoId: crypto.id,
                                    cryptoName: crypto.name,
                                    viewModel: container.resolve(CryptoDetailViewModel.self)!
                                )
                            }
                        }
                        .tabItem {
                            Label(AppStrings.market, image: AppImages.searchList)
                        }
                        .tag(0)
                        
                        NavigationStack {
                            FavoriteListView(
                                viewModel: container.resolve(FavoriteListViewModel.self)!
                            ) { cryptoId, name in
                                selectedCrypto = CryptoSelection(
                                    id: cryptoId,
                                    name: name
                                )
                            }
                            .navigationDestination(item: $selectedCrypto) { crypto in
                                CryptoDetailView(
                                    cryptoId: crypto.id,
                                    cryptoName: crypto.name,
                                    viewModel: container.resolve(CryptoDetailViewModel.self)!
                                )
                            }
                        }
                        .tabItem {
                            Label(AppStrings.favorite,
                                  systemImage: AppImages.favorite)
                        }
                        .tag(1)
                        
                        NavigationStack {
                            SettingsView(
                                viewModel: container.resolve(SettingsViewModel.self)!,
                                onLogout: {
                                    appRootManager.currentRoot = .authentication
                                }
                            )
                            
                        }
                        .tabItem {
                            Label(
                                AppStrings.settings,
                                systemImage: AppImages.settingsConfiguracion
                            )
                        }
                        .tag(2)
                    }
                }
            }
            .environmentObject(appRootManager)
            .onChange(of: appRootManager.pendingDeepLink) { deepLink in
                guard let deepLink else {
                    return
                }
                
                switch deepLink {
                case .crypto(let id):
                    selectedCrypto = CryptoSelection(
                        id: id,
                        name: id.capitalized
                    )
                case .favorites:
                    selectedTab = 1
                }
                appRootManager.pendingDeepLink = nil
            }
            .onOpenURL { url in
                guard let deepLink = DeepLink(url: url) else {
                    return
                }
                print(deepLink)
                
                if KeychainManager.shared.getToken() == nil {
                    appRootManager.pendingDeepLink = deepLink
                    appRootManager.currentRoot = .authentication
                } else {
                    appRootManager.pendingDeepLink = deepLink
                }
            }
        }
        .modelContainer(for: [FavoriteCryptoEntity.self])
    }
}

private struct CryptoSelection: Identifiable, Hashable {
    let id: String
    let name: String
}
