import Foundation

// MARK: - Digital Wallet Operations

extension BSICardsClient {

    public func digitalCreateVirtualCard(
        userEmail: String,
        firstName: String,
        lastName: String,
        dateOfBirth: String,
        address: String,
        postalCode: String,
        city: String,
        countryCode: String,
        state: String,
        countryPhone: String,
        phone: String
    ) async throws -> APIResponse<CardResponse> {
        let request = VirtualCardCreationRequest(
            userEmail: userEmail,
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            address: address,
            postalCode: postalCode,
            city: city,
            countryCode: countryCode,
            state: state,
            countryPhone: countryPhone,
            phone: phone
        )
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "digitalnewvirtualcard", body: data)
    }

    public func digitalGetAllCards(userEmail: String) async throws -> [Card] {
        let request = ["useremail": userEmail]
        let data = try encoder.encode(request)

        let response: APIResponse<[Card]> = try await self.request(method: "POST", endpoint: "getalldigital", body: data)
        return response.data ?? []
    }

    public func digitalGetCard(userEmail: String, cardId: String) async throws -> Card {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        let response: APIResponse<Card> = try await self.request(method: "POST", endpoint: "getdigitalcard", body: data)
        guard let card = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return card
    }

    public func digitalFundCard(
        userEmail: String,
        cardId: String,
        amount: String
    ) async throws -> APIResponse<MessageResponse> {
        let request = FundCardRequest(userEmail: userEmail, cardId: cardId, amount: amount)
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "digitalfundcard", body: data)
    }

    public func digitalFreezeCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse> {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "blockdigital", body: data)
    }

    public func digitalUnfreezeCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse> {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "unblockdigital", body: data)
    }

    public func digitalCheck3DS(userEmail: String) async throws -> APIResponse<MessageResponse> {
        let request = ["useremail": userEmail]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "checkwallet", body: data)
    }

    public func digitalApprove3DS(
        userEmail: String,
        cardId: String,
        eventId: String
    ) async throws -> APIResponse<MessageResponse> {
        let request = ["useremail": userEmail, "cardid": cardId, "eventId": eventId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "approve3ds", body: data)
    }

    public func digitalTerminateCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse> {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "terminatedigitalcard", body: data)
    }

    public func digitalCreateAddonCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse> {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "createaddon", body: data)
    }

    public func digitalGetLoyaltyPoints(userEmail: String, cardId: String) async throws -> LoyaltyPoints {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        let response: APIResponse<LoyaltyPoints> = try await self.request(method: "POST", endpoint: "digitalcardpoints", body: data)
        guard let points = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return points
    }

    public func digitalRedeemPoints(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse> {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "redeempoints", body: data)
    }
}

