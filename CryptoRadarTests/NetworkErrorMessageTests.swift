import XCTest
@testable import NetworkKit

final class NetworkErrorMessageTests: XCTestCase {

    func testMessageForTransportError() {
        let message = NetworkError.message(
            for: NetworkError.transport(.notConnectedToInternet),
            fallback: "Error genérico"
        )

        XCTAssertEqual(message, "No hay conexión a internet.")
    }

    func testMessageForRateLimitError() {
        let message = NetworkError.message(
            for: NetworkError.server(statusCode: 429),
            fallback: "Error genérico"
        )

        XCTAssertEqual(message, "Demasiadas solicitudes. Intenta más tarde.")
    }
}
