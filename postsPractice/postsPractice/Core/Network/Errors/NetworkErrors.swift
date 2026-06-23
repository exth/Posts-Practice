import Foundation


// MARK: - 'NetworksError' will be expanded in the future. Now - basic errors.
enum NetworkError: LocalizedError {
    case invalidRequest
    case serverError(Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "Internal error. Try again later"
        case .serverError(let code):
            return "The service is temporarily unavailable. Eror: \(code)"
        case .unknown:
            return "Something went wrong"
        }
    }
}
