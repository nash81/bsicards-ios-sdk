# BSICARDS iOS SDK - API Reference

## Overview

Complete API reference for the BSICARDS iOS SDK. All methods use async/await for modern Swift concurrency.

## Base URL

```
https://cards.bsigroup.tech/api/
```

## Authentication

All requests require:
- `publickey` header - Your public API key
- `secretkey` header - Your secret API key

## MasterCard Operations

### mastercardCreateCard

Create a new MasterCard.

```swift
func mastercardCreateCard(
    userEmail: String,
    nameOnCard: String,
    pin: String
) async throws -> APIResponse<CardResponse>
```

**Parameters:**
- `userEmail`: User's email address
- `nameOnCard`: Name to print on card
- `pin`: 4-digit PIN

**Example:**
```swift
let response = try await client.mastercardCreateCard(
    userEmail: "user@example.com",
    nameOnCard: "John Doe",
    pin: "1234"
)
```

### mastercardGetAllCards

Get all MasterCards for a user.

```swift
func mastercardGetAllCards(userEmail: String) async throws -> [Card]
```

### mastercardGetCard

Get specific MasterCard details.

```swift
func mastercardGetCard(userEmail: String, cardId: String) async throws -> Card
```

### mastercardChangePin

Change MasterCard PIN.

```swift
func mastercardChangePin(
    userEmail: String,
    cardId: String,
    newPin: String
) async throws -> APIResponse<MessageResponse>
```

### mastercardFreezeCard

Freeze a MasterCard.

```swift
func mastercardFreezeCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse>
```

### mastercardUnfreezeCard

Unfreeze a MasterCard.

```swift
func mastercardUnfreezeCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse>
```

### mastercardFundCard

Fund a MasterCard.

```swift
func mastercardFundCard(
    userEmail: String,
    cardId: String,
    amount: String
) async throws -> APIResponse<MessageResponse>
```

**Note:** Minimum amount is $10.00

---

## Visa Card Operations

### visaCreateCard

Create a new Visa card.

```swift
func visaCreateCard(
    userEmail: String,
    name: String,
    nationalId: String,
    idUrl: String,
    photoUrl: String,
    dateOfBirth: String
) async throws -> APIResponse<CardResponse>
```

### getAllVisaCards

Get all Visa cards for a user.

```swift
func getAllVisaCards(userEmail: String) async throws -> [Card]
```

### getVisaCardDetails

Get specific Visa card details.

```swift
func getVisaCardDetails(userEmail: String, cardId: String) async throws -> Card
```

### freezeVisaCard / unfreezeVisaCard

Freeze or unfreeze a Visa card.

```swift
func freezeVisaCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse>
func unfreezeVisaCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse>
```

### fundVisaCard

Fund a Visa card.

```swift
func fundVisaCard(
    userEmail: String,
    cardId: String,
    amount: String
) async throws -> APIResponse<MessageResponse>
```

---

## Digital Wallet Operations

### digitalCreateVirtualCard

Create a virtual card.

```swift
func digitalCreateVirtualCard(
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
) async throws -> APIResponse<CardResponse>
```

### digitalGetAllCards

Get all virtual cards.

```swift
func digitalGetAllCards(userEmail: String) async throws -> [Card]
```

### digitalGetCard

Get virtual card details.

```swift
func digitalGetCard(userEmail: String, cardId: String) async throws -> Card
```

### digitalFundCard

Fund a virtual card.

```swift
func digitalFundCard(
    userEmail: String,
    cardId: String,
    amount: String
) async throws -> APIResponse<MessageResponse>
```

### digitalCheck3DS

Check 3DS verification status.

```swift
func digitalCheck3DS(userEmail: String) async throws -> APIResponse<MessageResponse>
```

### digitalApprove3DS

Approve a 3DS transaction.

```swift
func digitalApprove3DS(
    userEmail: String,
    cardId: String,
    eventId: String
) async throws -> APIResponse<MessageResponse>
```

### digitalTerminateCard

Terminate a digital card.

```swift
func digitalTerminateCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse>
```

### digitalCreateAddonCard

Create an add-on card.

```swift
func digitalCreateAddonCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse>
```

**Note:** Add-on cards are charged $4.50 and share balance with parent card.

### digitalGetLoyaltyPoints

Get loyalty points balance.

```swift
func digitalGetLoyaltyPoints(userEmail: String, cardId: String) async throws -> LoyaltyPoints
```

### digitalRedeemPoints

Redeem loyalty points.

```swift
func digitalRedeemPoints(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse>
```

---

## Digital Visa Wallet Operations

### digitalVisaCreateVirtualCard

Create a Digital Visa virtual wallet card.

```swift
func digitalVisaCreateVirtualCard(
    userEmail: String,
    firstName: String,
    lastName: String
) async throws -> APIResponse<DigitalVisaCardCreationData>
```

### digitalVisaGetAllCards

Get all Digital Visa wallet cards for a user.

```swift
func digitalVisaGetAllCards(userEmail: String) async throws -> [DigitalVisaCardSummary]
```

### digitalVisaGetCard

Get details for a Digital Visa wallet card.

```swift
func digitalVisaGetCard(userEmail: String, cardId: String) async throws -> DigitalVisaCardDetails
```

### digitalVisaFundCard

Fund a Digital Visa wallet card.

```swift
func digitalVisaFundCard(
    userEmail: String,
    cardId: String,
    amount: String
) async throws -> APIResponse<MessageResponse>
```

**Note:** The Postman collection states a minimum funding amount of $5.00.

### digitalVisaGetOTP

Get OTP details for Digital Visa wallet card actions.

```swift
func digitalVisaGetOTP(userEmail: String, cardId: String) async throws -> APIResponse<DigitalVisaOTPData>
```

### digitalVisaFreezeCard / digitalVisaUnfreezeCard

Block or unblock a Digital Visa wallet card.

```swift
func digitalVisaFreezeCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse>
func digitalVisaUnfreezeCard(userEmail: String, cardId: String) async throws -> APIResponse<MessageResponse>
```

---

## Administrator Operations

### getWalletBalance

Get account wallet balance.

```swift
func getWalletBalance() async throws -> BalanceResponse
```

### getDeposits

Get all deposits.

```swift
func getDeposits() async throws -> [Deposit]
```

### getTransactions

Get all transactions.

```swift
func getTransactions() async throws -> [Transaction]
```

### getAllVisaCards (Admin)

Get all Visa cards in account.

```swift
func getAllVisaCards() async throws -> [Card]
```

### getAllMastercards (Admin)

Get all MasterCards in account.

```swift
func getAllMastercards() async throws -> [Card]
```

### getAllDigitalCards (Admin)

Get all digital cards in account.

```swift
func getAllDigitalCards() async throws -> [Card]
```

---

## Wallet As A Service Operations

### Swap

#### getExchangeCurrencies

```swift
func getExchangeCurrencies() async throws -> [Currency]
```

#### getExchangeStatus

```swift
func getExchangeStatus(transactionId: String) async throws -> ExchangeStatus
```

#### estimateExchange

```swift
func estimateExchange(from: String, to: String, networkFrom: String, networkTo: String, amount: Double) async throws -> ExchangeEstimate
```

#### createExchange

```swift
func createExchange(request: ExchangeCreateRequest) async throws -> ExchangeCreateResponse
```

### Wallet

#### createWalletAddress

```swift
func createWalletAddress(userEmail: String, coin: String) async throws -> WalletAddress
```

#### getAllWalletAddresses

```swift
func getAllWalletAddresses(userEmail: String) async throws -> [WalletAddress]
```

#### getWalletAddress

```swift
func getWalletAddress(uuid: String, userEmail: String) async throws -> WalletAddress
```

#### getWalletBalance

```swift
func getWalletBalance(uuid: String, userEmail: String) async throws -> WalletBalance
```

#### getWithdrawalFee

```swift
func getWithdrawalFee(request: WithdrawalFeeRequest) async throws -> WithdrawalFee
```

#### withdraw

```swift
func withdraw(request: WithdrawRequest) async throws -> WithdrawResponse
```

#### getWithdrawalStatus

```swift
func getWithdrawalStatus(txHash: String, coin: String) async throws -> WithdrawalStatus
```

---

## Data Models

### APIResponse<T>

Generic API response wrapper.

```swift
struct APIResponse<T: Codable>: Codable {
    let code: Int
    let status: String
    let message: String
    let data: T?
}
```

### Card

Card details model.

```swift
struct Card: Codable {
    let cardId: String
    let cardNumber: String?
    let cardholderName: String
    let expiryDate: String?
    let status: String
    let balance: String?
    let availableBalance: String?
}
```

### Transaction

Transaction details model.

```swift
struct Transaction: Codable {
    let transactionId: String
    let amount: String
    let currency: String
    let type: String
    let timestamp: String
    let status: String
}
```

### Digital Visa Models

Digital Visa wallet endpoints use dedicated models:

- `DigitalVisaCardCreationData`
- `DigitalVisaCardSummary`
- `DigitalVisaCardDetails`
- `DigitalVisaOTPData`

---

## Error Handling

### BSICardsError

```swift
enum BSICardsError: LocalizedError {
    case validationError(String)
    case networkError(String)
    case apiError(code: Int, message: String)
    case decodingError(String)
    case invalidURL
    case invalidCredentials
    case serverError(Int)
}
```

**Usage:**

```swift
do {
    let response = try await client.mastercardCreateCard(...)
} catch let error as BSICardsError {
    switch error {
    case .validationError(let message):
        print("Validation error: \(message)")
    case .networkError(let message):
        print("Network error: \(message)")
    case .apiError(let code, let message):
        print("API error \(code): \(message)")
    default:
        print("Other error: \(error.errorDescription ?? "Unknown")")
    }
} catch {
    print("Unexpected error: \(error.localizedDescription)")
}
```

---

## HTTP Status Codes

- `200` - Success
- `400` - Bad Request (invalid parameters)
- `401` - Unauthorized (invalid credentials)
- `403` - Forbidden (access denied)
- `429` - Too Many Requests (rate limited)
- `500` - Server Error

---

## Response Format

All responses follow this format:

```json
{
    "code": 200,
    "status": "success",
    "message": "Operation description",
    "data": {}
}
```

---

## Rate Limiting

The API implements rate limiting. If you exceed limits, you'll receive a `429` response. Implement exponential backoff for retries.

---

## Best Practices

1. Always handle errors with try/catch
2. Use @MainActor when updating UI
3. Validate input before sending
4. Store credentials securely in Keychain
5. Never hardcode API keys

