import Foundation

public enum BSICardsError: LocalizedError {
    case validationError(String)
    case networkError(String)
    case apiError(code: Int, message: String)
    case decodingError(String)
    case invalidURL
    case invalidCredentials
    case serverError(Int)

    public var errorDescription: String? {
        switch self {
        case .validationError(let message):
            return "Validation Error: \(message)"
        case .networkError(let message):
            return "Network Error: \(message)"
        case .apiError(let code, let message):
            return "API Error \(code): \(message)"
        case .decodingError(let message):
            return "Decoding Error: \(message)"
        case .invalidURL:
            return "Invalid URL"
        case .invalidCredentials:
            return "Invalid API credentials"
        case .serverError(let code):
            return "Server Error: \(code)"
        }
    }

    public var failureReason: String? {
        switch self {
        case .validationError:
            return "Input validation failed"
        case .networkError:
            return "Network connectivity issue"
        case .apiError:
            return "API returned an error"
        case .decodingError:
            return "Response decoding failed"
        case .invalidURL:
            return "Malformed URL"
        case .invalidCredentials:
            return "API keys are invalid or missing"
        case .serverError:
            return "Server error occurred"
        }
    }
}

