import Foundation

public enum NetworkError: Error {
    case invalidURL
    case transport(URLError.Code)
    case invalidResponse
    case server(statusCode: Int)
    case decoding
    case unknown
}

public extension NetworkError {
    static func message(for error: Error, fallback: String) -> String {
        guard let error = error as? NetworkError else {
            return fallback
        }

        switch error {
        case .transport:
            return "No hay conexión a internet."
        case .server(statusCode: 429):
            return "Demasiadas solicitudes. Intenta más tarde."
        case .server:
            return "El servidor no está disponible."
        case .decoding, .invalidResponse:
            return "La respuesta del servidor no es válida."
        case .invalidURL, .unknown:
            return fallback
        }
    }
}
