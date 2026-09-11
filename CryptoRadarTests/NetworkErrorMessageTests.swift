import Foundation
import Testing
@testable import NetworkKit

@Suite("NetworkErrorMessage")
@MainActor
struct NetworkErrorMessageTests {

    @Test("Transport error returns friendly message")
    func messageForTransportError() {
        let message = NetworkError.message(
            for: NetworkError.transport(.notConnectedToInternet),
            fallback: "Error genérico"
        )

        #expect(message == "No hay conexión a internet.")
    }

    @Test("Rate limit error returns friendly message")
    func messageForRateLimitError() {
        let message = NetworkError.message(
            for: NetworkError.server(statusCode: 429),
            fallback: "Error genérico"
        )

        #expect(message == "Demasiadas solicitudes. Intenta más tarde.")
    }
}
