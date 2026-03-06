import Foundation

// MARK: - Administrator Operations

extension BSICardsClient {

    public func getWalletBalance() async throws -> BalanceResponse {
        let response: APIResponse<BalanceResponse> = try await request(method: "GET", endpoint: "admin/balance")
        guard let balance = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return balance
    }

    public func getDeposits() async throws -> [Deposit] {
        let response: APIResponse<[Deposit]> = try await request(method: "GET", endpoint: "admin/deposits")
        return response.data ?? []
    }

    public func getTransactions() async throws -> [Transaction] {
        let response: APIResponse<[Transaction]> = try await request(method: "GET", endpoint: "admin/transactions")
        return response.data ?? []
    }

    public func getAllVisaCards() async throws -> [Card] {
        let response: APIResponse<[Card]> = try await request(method: "GET", endpoint: "admin/visacards")
        return response.data ?? []
    }

    public func getAllMastercards() async throws -> [Card] {
        let response: APIResponse<[Card]> = try await request(method: "GET", endpoint: "admin/mastercards")
        return response.data ?? []
    }

    public func getAllDigitalCards() async throws -> [Card] {
        let response: APIResponse<[Card]> = try await request(method: "GET", endpoint: "admin/digitalcards")
        return response.data ?? []
    }
}

