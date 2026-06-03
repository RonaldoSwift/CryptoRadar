import Register
import StorageKit
import Login
import SwiftUI
import Foundation

enum Route: Hashable {
    case register
}

struct AuthenticationRootView: View {
    
    @EnvironmentObject var appRootManager: AppRootManager
    @State private var path = NavigationPath()
    var loginViewModel: LoginViewModel
    var registerViewModel: RegisterViewModel
    
    var body: some View {
        NavigationStack(path: $path) {
            LoginView(
                viewModel: loginViewModel,
                onLoginSuccess: {
                    KeychainManager.shared.saveToken(
                        loginViewModel.token
                    )
                    appRootManager.currentRoot = .principal
                },
                
                onRegisterTap: {
                    path.append(Route.register)
                }
            )
            
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .register:
                    RegisterView(
                        viewModel: registerViewModel,
                        onRegisterSuccess: {
                            path.removeLast()
                        },
                        onLoginTap: {
                            path.removeLast()
                        }
                    )
                }
            }
        }
    }
}
