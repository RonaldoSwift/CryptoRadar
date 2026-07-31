import Swinject
import NetworkKit

public final class NetworkAssembly: Assembly {

    public init() {}


    public func assemble(container: Container) {

        container.register(ApiClient.self) { _ in
            ApiClient()
        }
    }
}