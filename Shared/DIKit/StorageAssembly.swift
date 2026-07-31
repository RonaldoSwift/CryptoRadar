import Swinject
import StorageKit

public final class StorageAssembly: Assembly {

    public init() {}


    public func assemble(container: Container) {

        container.register(KeychainManager.self) { _ in
            KeychainManager()
        }
    }
}