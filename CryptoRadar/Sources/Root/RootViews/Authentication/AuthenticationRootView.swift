import Register
import Login
import SwiftUI

struct AuthenticationRootView: View {

    @EnvironmentObject var appRootManager: AppRootManager

    @State private var isActiveRegister = false

    var loginViewModel: LoginViewModel
    var registerViewModel: RegisterViewModel

    var body: some View {

        NavigationStack {
            LoginView(
                viewModel: loginViewModel,
                onLoginSuccess: {
                    appRootManager.currentRoot = .principal
                },
                onRegisterTap: {
                    isActiveRegister = true
                }
            )
            .navigationDestination(
                isPresented: $isActiveRegister
            ) {
                RegisterView(
                    viewModel: registerViewModel,
                    onRegisterSuccess: {
                        isActiveRegister = false
                    },
                    onLoginTap: {
                        isActiveRegister = false
                    }
                )
            }
        }
    }
}
