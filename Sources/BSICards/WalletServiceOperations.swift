// WalletServiceOperations.swift
// Handles Wallet As A Service endpoints (Swap & Wallet)

import Foundation

public class WalletServiceOperations {
    private let client: BSICardsClient

    public init(client: BSICardsClient) {
        self.client = client
    }

    // MARK: - Swap
    public func getExchangeCurrencies() async throws -> [Currency] {
        let response: APIResponse<[Currency]> = try await client.request(method: "GET", endpoint: "exchange/currencies")
        return response.data ?? []
    }
    public func getExchangeStatus(transactionId: String) async throws -> ExchangeStatus {
        let params = ["transaction_id": transactionId]
        let response: APIResponse<ExchangeStatus> = try await client.request(method: "GET", endpoint: "exchange/status", query: params)
        guard let status = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return status
    }
    public func estimateExchange(from: String, to: String, networkFrom: String, networkTo: String, amount: Double) async throws -> ExchangeEstimate {
        let request = [
            "from": from,
            "to": to,
            "network_from": networkFrom,
            "network_to": networkTo,
            "amount": amount
        ] as [String: Any]
        let data = try JSONSerialization.data(withJSONObject: request)
        let response: APIResponse<ExchangeEstimate> = try await client.request(method: "POST", endpoint: "exchange/estimate", body: data)
        guard let estimate = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return estimate
    }
    public func createExchange(request: ExchangeCreateRequest) async throws -> ExchangeCreateResponse {
        let data = try client.encoder.encode(request)
        let response: APIResponse<ExchangeCreateResponse> = try await client.request(method: "POST", endpoint: "exchange/create", body: data)
        guard let result = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return result
    }
    // MARK: - Wallet
    public func createWalletAddress(userEmail: String, coin: String) async throws -> WalletAddress {
        let request = ["useremail": userEmail, "coin": coin]
        let data = try client.encoder.encode(request)
        let response: APIResponse<WalletAddress> = try await client.request(method: "POST", endpoint: "wallet/create-address", body: data)
        guard let address = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return address
    }
    public func getAllWalletAddresses(userEmail: String) async throws -> [WalletAddress] {
        let params = ["useremail": userEmail]
        let response: APIResponse<[WalletAddress]> = try await client.request(method: "GET", endpoint: "wallet/addresses", query: params)
        return response.data ?? []
    }
    public func getWalletAddress(uuid: String, userEmail: String) async throws -> WalletAddress {
        let params = ["useremail": userEmail]
        let endpoint = "wallet/address/\(uuid)"
        let response: APIResponse<WalletAddress> = try await client.request(method: "GET", endpoint: endpoint, query: params)
        guard let address = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return address
    }
    public func getWalletBalance(uuid: String, userEmail: String) async throws -> WalletBalance {
        let params = ["uuid": uuid, "useremail": userEmail]
        let response: APIResponse<WalletBalance> = try await client.request(method: "GET", endpoint: "wallet/balance", query: params)
        guard let balance = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return balance
    }
    public func getWithdrawalFee(request: WithdrawalFeeRequest) async throws -> WithdrawalFee {
        let data = try client.encoder.encode(request)
        let response: APIResponse<WithdrawalFee> = try await client.request(method: "POST", endpoint: "wallet/withdrawal-fee", body: data)
        guard let fee = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return fee
    }
    public func withdraw(request: WithdrawRequest) async throws -> WithdrawResponse {
        let data = try client.encoder.encode(request)
        let response: APIResponse<WithdrawResponse> = try await client.request(method: "POST", endpoint: "wallet/withdraw", body: data)
        guard let result = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return result
    }
    public func getWithdrawalStatus(txHash: String, coin: String) async throws -> WithdrawalStatus {
        let request = ["tx_hash": txHash, "coin": coin]
        let data = try client.encoder.encode(request)
        let response: APIResponse<WithdrawalStatus> = try await client.request(method: "POST", endpoint: "wallet/withdrawal-status", body: data)
        guard let status = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return status
    }
}
