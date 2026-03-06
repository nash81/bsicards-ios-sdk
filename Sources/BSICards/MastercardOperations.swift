import Foundation

// MARK: - MasterCard Operations

extension BSICardsClient {

    public func mastercardCreateCard(
        userEmail: String,
        nameOnCard: String,
        pin: String
    ) async throws -> APIResponse<CardResponse> {
        try validateInput(userEmail, nameOnCard, pin)

        let request = CardCreationRequest(userEmail: userEmail, nameOnCard: nameOnCard, pin: pin)
        let data = try encoder.encode(request)

        return try await request(method: "POST", endpoint: "newcard", body: data)
    }

    public func mastercardGetAllCards(userEmail: String) async throws -> [Card] {
        try validateInput(userEmail)

        let request = ["useremail": userEmail]
        let data = try encoder.encode(request)

        let response: APIResponse<[Card]> = try await self.request(method: "POST", endpoint: "getallcard", body: data)
        return response.data ?? []
    }

    public func mastercardGetPendingCards(userEmail: String) async throws -> [Card] {
        try validateInput(userEmail)

        let request = ["useremail": userEmail]
        let data = try encoder.encode(request)

        let response: APIResponse<[Card]> = try await self.request(method: "POST", endpoint: "getpendingcards", body: data)
        return response.data ?? []
    }

    public func mastercardGetCard(userEmail: String, cardId: String) async throws -> Card {
        try validateInput(userEmail, cardId)

        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        let response: APIResponse<Card> = try await self.request(method: "POST", endpoint: "getcard", body: data)
        guard let card = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return card
    }

    public func mastercardChangePin(
        userEmail: String,
        cardId: String,
        newPin: String
    ) async throws -> APIResponse<MessageResponse> {
        try validateInput(userEmail, cardId, newPin)

        let request = ChangePinRequest(userEmail: userEmail, cardId: cardId, newPin: newPin)
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "changepin", body: data)
    }

    public func mastercardFreezeCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse> {
        try validateInput(userEmail, cardId)

        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "blockcard", body: data)
    }

    public func mastercardUnfreezeCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse> {
        try validateInput(userEmail, cardId)

        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "unblockcard", body: data)
    }

    public func mastercardFundCard(
        userEmail: String,
        cardId: String,
        amount: String
    ) async throws -> APIResponse<MessageResponse> {
        try validateInput(userEmail, cardId, amount)
        try validateAmount(amount)

        let request = FundCardRequest(userEmail: userEmail, cardId: cardId, amount: amount)
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "fundcard", body: data)
    }

    // MARK: - Private Validation Methods

    private func validateInput(_ inputs: String...) throws {
        for input in inputs {
            guard !input.trimmingCharacters(in: .whitespaces).isEmpty else {
                throw BSICardsError.validationError("Input cannot be empty")
            }
        }
    }

    private func validateAmount(_ amount: String) throws {
        guard let doubleAmount = Double(amount), doubleAmount >= 10.0 else {
            throw BSICardsError.validationError("Minimum amount is $10.00")
        }
    }
}

