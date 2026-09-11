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

    // Esta funcion sirve para mapear los errores de red a mensajes que sean comprensibles para el usuario final.
    // Los parametros de entrada son:
    // - error: El error que queremos mapear a un mensaje amigable.
    // - fallback: Un mensaje de error por defecto que se usará si no podemos mapear el error a un mensaje amigable.
    // La funcion devuelve un String que es el mensaje de error amigable para el usuario.
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
