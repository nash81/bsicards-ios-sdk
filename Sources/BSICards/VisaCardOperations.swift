import Foundation

// MARK: - Visa Card Operations

extension BSICardsClient {

    public func visaCreateCard(
        userEmail: String,
        name: String,
        nationalId: String,
        idUrl: String,
        photoUrl: String,
        dateOfBirth: String
    ) async throws -> APIResponse<CardResponse> {
        let request = VisaCardCreationRequest(
            userEmail: userEmail,
            name: name,
            nationalId: nationalId,
            idUrl: idUrl,
            photoUrl: photoUrl,
            dateOfBirth: dateOfBirth
        )
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "createnewvisacard", body: data)
    }

    public func getAllVisaCards(userEmail: String) async throws -> [Card] {
        let request = ["useremail": userEmail]
        let data = try encoder.encode(request)

        let response: APIResponse<[Card]> = try await self.request(method: "POST", endpoint: "getallvisacards", body: data)
        return response.data ?? []
    }

    public func getPendingVisaCards(userEmail: String) async throws -> [Card] {
        let request = ["useremail": userEmail]
        let data = try encoder.encode(request)

        let response: APIResponse<[Card]> = try await self.request(method: "POST", endpoint: "getpendingvisacards", body: data)
        return response.data ?? []
    }

    public func getVisaCardDetails(userEmail: String, cardId: String) async throws -> Card {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        let response: APIResponse<Card> = try await self.request(method: "POST", endpoint: "getvisacard", body: data)
        guard let card = response.data else {
            throw BSICardsError.apiError(code: response.code, message: response.message)
        }
        return card
    }

    public func freezeVisaCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse> {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "blockvisacard", body: data)
    }

    public func unfreezeVisaCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse> {
        let request = ["useremail": userEmail, "cardid": cardId]
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "unblockvisacard", body: data)
    }

    public func fundVisaCard(
        userEmail: String,
        cardId: String,
        amount: String
    ) async throws -> APIResponse<MessageResponse> {
        let request = FundCardRequest(userEmail: userEmail, cardId: cardId, amount: amount)
        let data = try encoder.encode(request)

        return try await self.request(method: "POST", endpoint: "fundvisacard", body: data)
    }
}

