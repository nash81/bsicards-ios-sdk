# BSICARDS iOS SDK

A comprehensive Swift SDK for integrating with the BSICARDS Card Issuance API. Create and manage Mastercard, Visa, and Digital Wallet cards with ease on iOS.

[![iOS](https://img.shields.io/badge/iOS-13.0+-brightgreen)](https://www.apple.com/ios/)
[![Swift](https://img.shields.io/badge/swift-5.5+-orange)](https://swift.org/)
[![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE)
[![CocoaPods](https://img.shields.io/badge/cocoapods-available-brightgreen)](https://cocoapods.org/)

## Features

- ✅ **MasterCard Issuance** - Create and manage MasterCards
- ✅ **Visa Card Issuance** - Create and manage Visa Cards
- ✅ **Digital Wallet Cards** - Create and manage Digital Wallet cards
- ✅ **Card Management** - Freeze, unfreeze, change PIN, view transactions
- ✅ **Card Funding** - Fund cards with minimum $10.00
- ✅ **3DS Support** - Full 3DS authentication and approval
- ✅ **Loyalty Points** - Get and redeem loyalty points
- ✅ **Administrator Operations** - Get wallet balance, deposits, transactions
- ✅ **Async/Await Support** - Modern Swift concurrency
- ✅ **Type Safe** - Full Swift type safety with Codable
- ✅ **Error Handling** - Custom error types

## Requirements

- iOS 13.0+
- Swift 5.5+
- Xcode 12.0+

## Installation

### Via CocoaPods

```ruby
pod 'BSICards', '~> 1.0.0'
```

Then run:

```bash
pod install
```

### Via Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/nash81/bsicards-ios-sdk.git", from: "1.0.0")
]
```

### Manual Installation

1. Clone the repository
2. Add `BSICards.xcodeproj` to your Xcode project
3. Link against the `BSICards` framework

## Configuration

### Setup

```swift
import BSICards

// Initialize with credentials
let client = BSICardsClient(
    publicKey: "your_public_key",
    secretKey: "your_secret_key"
)

// Or use environment variables
let client = BSICardsClient() // Reads from environment
```

### Environment Variables

Set in your app or Xcode scheme:

```
BSICARDS_PUBLIC_KEY=your_public_key
BSICARDS_SECRET_KEY=your_secret_key
```

## Quick Start

### Create a MasterCard

```swift
import BSICards

let client = BSICardsClient()

Task {
    do {
        let response = try await client.mastercardCreateCard(
            userEmail: "user@example.com",
            nameOnCard: "John Doe",
            pin: "1234"
        )

        print("Card created: \(response.message)")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

### Get All Visa Cards

```swift
Task {
    do {
        let cards = try await client.getAllVisaCards(
            userEmail: "user@example.com"
        )

        for card in cards {
            print("Card: \(card.cardId) - Balance: \(card.balance)")
        }
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

### Fund a Card

```swift
Task {
    do {
        let response = try await client.fundMastercard(
            userEmail: "user@example.com",
            cardId: "card-123",
            amount: "50.00"
        )

        print("Funding status: \(response.message)")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

## API Methods

### MasterCard Operations

```swift
// Create a MasterCard
try await client.mastercardCreateCard(userEmail:, nameOnCard:, pin:)

// Get all MasterCards
try await client.mastercardGetAllCards(userEmail:)

// Get pending MasterCards
try await client.mastercardGetPendingCards(userEmail:)

// Get card details
try await client.mastercardGetCard(userEmail:, cardId:)

// Change PIN
try await client.mastercardChangePin(userEmail:, cardId:, newPin:)

// Freeze/Unfreeze
try await client.mastercardFreezeCard(userEmail:, cardId:)
try await client.mastercardUnfreezeCard(userEmail:, cardId:)

// Fund card
try await client.mastercardFundCard(userEmail:, cardId:, amount:)
```

### Visa Card Operations

```swift
// Create Visa card
try await client.visaCreateCard(userEmail:, name:, nationalId:, idUrl:, photoUrl:, dateOfBirth:)

// Get all Visa cards
try await client.getAllVisaCards(userEmail:)

// Get pending Visa cards
try await client.getPendingVisaCards(userEmail:)

// Get card details
try await client.getVisaCardDetails(userEmail:, cardId:)

// Freeze/Unfreeze
try await client.freezeVisaCard(userEmail:, cardId:)
try await client.unfreezeVisaCard(userEmail:, cardId:)

// Fund card
try await client.fundVisaCard(userEmail:, cardId:, amount:)
```

### Digital Wallet Operations

```swift
// Create virtual card
try await client.digitalCreateVirtualCard(userEmail:, firstName:, lastName:, dateOfBirth:, address:, postalCode:, city:, countryCode:, state:, countryPhone:, phone:)

// Get all digital cards
try await client.digitalGetAllCards(userEmail:)

// Get card details
try await client.digitalGetCard(userEmail:, cardId:)

// Fund card
try await client.digitalFundCard(userEmail:, cardId:, amount:)

// Freeze/Unfreeze
try await client.digitalFreezeCard(userEmail:, cardId:)
try await client.digitalUnfreezeCard(userEmail:, cardId:)

// 3DS Operations
try await client.digitalCheck3DS(userEmail:)
try await client.digitalApprove3DS(userEmail:, cardId:, eventId:)

// Card Management
try await client.digitalTerminateCard(userEmail:, cardId:)
try await client.digitalCreateAddonCard(userEmail:, cardId:)

// Loyalty Points
try await client.digitalGetLoyaltyPoints(userEmail:, cardId:)
try await client.digitalRedeemPoints(userEmail:, cardId:)
```

### Administrator Operations

```swift
// Get wallet balance
try await client.getWalletBalance()

// Get deposits
try await client.getDeposits()

// Get all transactions
try await client.getTransactions()

// Get all card types
try await client.getAllVisaCards()
try await client.getAllMastercards()
try await client.getAllDigitalCards()
```

## Error Handling

```swift
import BSICards

Task {
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
        case .decodingError(let message):
            print("Decoding error: \(message)")
        }
    } catch {
        print("Unexpected error: \(error.localizedDescription)")
    }
}
```

## Response Format

All API responses follow this format:

```swift
struct APIResponse<T: Codable>: Codable {
    let code: Int
    let status: String
    let message: String
    let data: T?
}
```

## Base URL

The SDK automatically uses:

```
https://cards.bsigroup.tech/api/
```

## Best Practices

1. **Never hardcode credentials** - Always use environment variables or secure storage
2. **Use async/await** - Modern Swift concurrency for clean code
3. **Handle errors properly** - Always catch and handle errors
4. **Validate input** - Check data before sending
5. **Use @MainActor** - Update UI on main thread

## Example: Complete Card Creation Flow

```swift
import SwiftUI
import BSICards

@MainActor
class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var isLoading = false
    @Published var error: String?

    private let client = BSICardsClient()

    func createCard(email: String, name: String, pin: String) {
        isLoading = true

        Task {
            do {
                let response = try await client.mastercardCreateCard(
                    userEmail: email,
                    nameOnCard: name,
                    pin: pin
                )

                print("Card created: \(response.message)")
                await loadCards(for: email)
            } catch {
                self.error = error.localizedDescription
            }

            isLoading = false
        }
    }

    private func loadCards(for email: String) async {
        do {
            let fetchedCards = try await client.mastercardGetAllCards(userEmail: email)
            self.cards = fetchedCards
        } catch {
            self.error = error.localizedDescription
        }
    }
}
```

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This SDK is released under the MIT License. See [LICENSE](LICENSE) for details.

## Support

For issues, questions, or support:

- Email: cs@bsigroup.tech
- Website: https://www.bsigroup.tech
- GitHub: https://github.com/nash81/bsicards-ios-sdk

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

## Disclaimer

This SDK is provided as-is. Always test in a sandbox environment before production use.

