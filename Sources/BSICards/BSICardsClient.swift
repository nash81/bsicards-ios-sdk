import Foundation

public class BSICardsClient {
    private let publicKey: String
    private let secretKey: String
    private let baseURL: String = "https://cards.bsigroup.tech/api/"
    private let session: URLSession
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    public init(publicKey: String? = nil, secretKey: String? = nil) {
        self.publicKey = publicKey ?? ProcessInfo.processInfo.environment["BSICARDS_PUBLIC_KEY"] ?? ""
        self.secretKey = secretKey ?? ProcessInfo.processInfo.environment["BSICARDS_SECRET_KEY"] ?? ""

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: config)
    }

    // MARK: - Private Methods

    private func request<T: Decodable>(
        method: String,
        endpoint: String,
        body: Data? = nil
    ) async throws -> T {
        guard !publicKey.isEmpty, !secretKey.isEmpty else {
            throw BSICardsError.invalidCredentials
        }

        guard let url = URL(string: baseURL + endpoint) else {
            throw BSICardsError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(publicKey, forHTTPHeaderField: "publickey")
        request.setValue(secretKey, forHTTPHeaderField: "secretkey")

        if let body = body {
            request.httpBody = body
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw BSICardsError.networkError("Invalid response")
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode >= 500 {
                throw BSICardsError.serverError(httpResponse.statusCode)
            } else {
                throw BSICardsError.apiError(code: httpResponse.statusCode, message: "Request failed")
            }
        }

        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw BSICardsError.decodingError(error.localizedDescription)
        }
    }

    // MARK: - Public Methods

    public func setPublicKey(_ key: String) {
        self.publicKey = key
    }

    public func setSecretKey(_ key: String) {
        self.secretKey = key
    }

    public func getPublicKey() -> String {
        return publicKey
    }

    public func getSecretKey() -> String {
        return secretKey
    }
}

