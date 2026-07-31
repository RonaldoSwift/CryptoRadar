import Swinject

public final class DependencyContainer {

    public static let shared = DependencyContainer()

    public let container: Container


    private init() {

        container = Container()

        registerDependencies()
    }


    private func registerDependencies() {

        let assemblies: [Assembly] = [
            NetworkAssembly(),
            StorageAssembly(),
            LoginAssembly()
        ]

        assemblies.forEach { assembly in
            assembly.assemble(container: container)
        }
    }
}