# BSICARDS iOS SDK - Code Examples

## Basic Setup

```swift
import SwiftUI
import BSICards

class CardManager {
    private let client = BSICardsClient()

    init(publicKey: String, secretKey: String) {
        self.client.setPublicKey(publicKey)
        self.client.setSecretKey(secretKey)
    }
}
```

## MasterCard Examples

### Create a MasterCard

```swift
Task {
    do {
        let response = try await client.mastercardCreateCard(
            userEmail: "user@example.com",
            nameOnCard: "John Doe",
            pin: "1234"
        )

        if response.code == 200 {
            print("Card created: \(response.message)")
        }
    } catch let error as BSICardsError {
        print("Error: \(error.errorDescription ?? "Unknown error")")
    } catch {
        print("Unexpected error: \(error.localizedDescription)")
    }
}
```

### Get All User Cards

```swift
Task {
    do {
        let cards = try await client.mastercardGetAllCards(userEmail: "user@example.com")

        for card in cards {
            print("Card: \(card.cardId) - Balance: \(card.availableBalance ?? "N/A")")
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
        let response = try await client.mastercardFundCard(
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

### Freeze/Unfreeze Card

```swift
Task {
    do {
        // Freeze
        let freezeResponse = try await client.mastercardFreezeCard(
            userEmail: "user@example.com",
            cardId: "card-123"
        )
        print("Freeze status: \(freezeResponse.message)")

        // Unfreeze
        let unfreezeResponse = try await client.mastercardUnfreezeCard(
            userEmail: "user@example.com",
            cardId: "card-123"
        )
        print("Unfreeze status: \(unfreezeResponse.message)")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

## Visa Card Examples

### Create a Visa Card

```swift
Task {
    do {
        let response = try await client.visaCreateCard(
            userEmail: "user@example.com",
            name: "John Doe",
            nationalId: "12345678",
            idUrl: "https://example.com/id.pdf",
            photoUrl: "https://example.com/photo.jpg",
            dateOfBirth: "1990-01-15"
        )

        print("Visa card created: \(response.message)")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

### Get All Visa Cards

```swift
Task {
    do {
        let visaCards = try await client.getAllVisaCards(userEmail: "user@example.com")
        print("Total Visa cards: \(visaCards.count)")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

## Digital Wallet Examples

### Create Virtual Card

```swift
Task {
    do {
        let response = try await client.digitalCreateVirtualCard(
            userEmail: "user@example.com",
            firstName: "John",
            lastName: "Doe",
            dateOfBirth: "1990-01-15",
            address: "128 City Road",
            postalCode: "EC1V 2NX",
            city: "London",
            countryCode: "GB",
            state: "England",
            countryPhone: "44",
            phone: "2071234567"
        )

        print("Virtual card created: \(response.message)")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

### Approve 3DS Transaction

```swift
Task {
    do {
        let response = try await client.digitalApprove3DS(
            userEmail: "user@example.com",
            cardId: "card-123",
            eventId: "3ds-event-id"
        )

        print("3DS approval status: \(response.message)")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

### Get and Redeem Loyalty Points

```swift
Task {
    do {
        // Get loyalty points
        let points = try await client.digitalGetLoyaltyPoints(
            userEmail: "user@example.com",
            cardId: "card-123"
        )
        print("Available points: \(points.balance)")

        // Redeem points
        let redeemResponse = try await client.digitalRedeemPoints(
            userEmail: "user@example.com",
            cardId: "card-123"
        )
        print("Redemption status: \(redeemResponse.message)")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

## Digital Visa Wallet Examples

### Create a Digital Visa Wallet Card

```swift
Task {
    do {
        let response = try await client.digitalVisaCreateVirtualCard(
            userEmail: "user@example.com",
            firstName: "John",
            lastName: "Doe"
        )

        print("Created card ID: \(response.data?.id ?? "N/A")")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

### Manage a Digital Visa Wallet Card

```swift
Task {
    do {
        let cards = try await client.digitalVisaGetAllCards(userEmail: "user@example.com")
        guard let card = cards.first else { return }

        let details = try await client.digitalVisaGetCard(userEmail: "user@example.com", cardId: card.cardId)
        print("Card status: \(details.status)")

        _ = try await client.digitalVisaFundCard(
            userEmail: "user@example.com",
            cardId: card.cardId,
            amount: "10.00"
        )

        let otp = try await client.digitalVisaGetOTP(userEmail: "user@example.com", cardId: card.cardId)
        print("OTP: \(otp.data?.otp ?? "Unavailable")")

        _ = try await client.digitalVisaFreezeCard(userEmail: "user@example.com", cardId: card.cardId)
        _ = try await client.digitalVisaUnfreezeCard(userEmail: "user@example.com", cardId: card.cardId)
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

## Administrator Examples

### Get Wallet Balance

```swift
Task {
    do {
        let balance = try await client.getWalletBalance()
        print("Wallet balance: \(balance.balance) \(balance.currency ?? "USD")")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

### Get All Card Statistics

```swift
Task {
    do {
        let visaCards = try await client.getAllVisaCards()
        let mastercards = try await client.getAllMastercards()
        let digitalCards = try await client.getAllDigitalCards()

        print("Visa cards: \(visaCards.count)")
        print("MasterCards: \(mastercards.count)")
        print("Digital cards: \(digitalCards.count)")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

## SwiftUI Integration

```swift
import SwiftUI
import BSICards

@MainActor
class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let client = BSICardsClient()

    func createCard(email: String, name: String, pin: String) {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                _ = try await client.mastercardCreateCard(
                    userEmail: email,
                    nameOnCard: name,
                    pin: pin
                )

                await loadCards(for: email)
            } catch let error as BSICardsError {
                errorMessage = error.errorDescription
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }

    private func loadCards(for email: String) async {
        do {
            cards = try await client.mastercardGetAllCards(userEmail: email)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = CardViewModel()
    @State private var email = ""
    @State private var cardName = ""
    @State private var pin = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Card Details")) {
                    TextField("Email", text: $email)
                    TextField("Name on Card", text: $cardName)
                    TextField("PIN", text: $pin)
                        .textContentType(.password)
                }

                Section {
                    Button(action: createCard) {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Create Card")
                        }
                    }
                    .disabled(viewModel.isLoading)
                }

                if let errorMessage = viewModel.errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }

                if !viewModel.cards.isEmpty {
                    Section(header: Text("Your Cards")) {
                        List(viewModel.cards, id: \.cardId) { card in
                            VStack(alignment: .leading) {
                                Text(card.cardholderName)
                                    .font(.headline)
                                Text("Balance: \(card.availableBalance ?? "N/A")")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("BSICARDS")
        }
    }

    private func createCard() {
        viewModel.createCard(email: email, name: cardName, pin: pin)
    }
}
```

## Error Handling Best Practices

```swift
func handleAPICall<T>(
    operation: @escaping () async throws -> T,
    onSuccess: @escaping (T) -> Void,
    onError: @escaping (String) -> Void
) {
    Task {
        do {
            let result = try await operation()
            await MainActor.run {
                onSuccess(result)
            }
        } catch let error as BSICardsError {
            let errorMsg = error.errorDescription ?? "Unknown error"
            await MainActor.run {
                onError(errorMsg)
            }
        } catch {
            await MainActor.run {
                onError(error.localizedDescription)
            }
        }
    }
}

// Usage
handleAPICall(
    operation: {
        try await client.mastercardCreateCard(
            userEmail: "user@example.com",
            nameOnCard: "John Doe",
            pin: "1234"
        )
    },
    onSuccess: { response in
        print("Success: \(response.message)")
    },
    onError: { error in
        print("Error: \(error)")
    }
)
```

