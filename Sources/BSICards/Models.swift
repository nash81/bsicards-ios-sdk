import Foundation

// MARK: - API Response Models

public struct APIResponse<T: Codable>: Codable {
    public let code: Int
    public let status: String
    public let message: String
    public let data: T?

    enum CodingKeys: String, CodingKey {
        case code, status, message, data
    }
}

// MARK: - Card Models

public struct Card: Codable {
    public let cardId: String
    public let cardNumber: String?
    public let cardholderName: String
    public let expiryDate: String?
    public let expiryMonth: Int?
    public let expiryYear: Int?
    public let cvv: String?
    public let status: String
    public let balance: String?
    public let availableBalance: String?
    public let createdAt: String?
    public let updatedAt: String?
    public let nameoncard: String?
    public let type: String?

    enum CodingKeys: String, CodingKey {
        case cardId = "cardid"
        case cardNumber = "card_number"
        case cardholderName = "cardholderName"
        case expiryDate = "expiry_date"
        case expiryMonth = "expiry_month"
        case expiryYear = "expiry_year"
        case cvv
        case status
        case balance
        case availableBalance = "available_balance"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case nameoncard
        case type
    }
}

// MARK: - Request Models

public struct CardCreationRequest: Codable {
    public let userEmail: String
    public let nameOnCard: String
    public let pin: String

    enum CodingKeys: String, CodingKey {
        case userEmail = "useremail"
        case nameOnCard = "nameoncard"
        case pin
    }

    public init(userEmail: String, nameOnCard: String, pin: String) {
        self.userEmail = userEmail
        self.nameOnCard = nameOnCard
        self.pin = pin
    }
}

public struct VisaCardCreationRequest: Codable {
    public let userEmail: String
    public let name: String
    public let nationalId: String
    public let idUrl: String
    public let photoUrl: String
    public let dateOfBirth: String

    enum CodingKeys: String, CodingKey {
        case userEmail = "useremail"
        case name
        case nationalId = "nationalid"
        case idUrl = "idurl"
        case photoUrl = "photourl"
        case dateOfBirth = "dob"
    }

    public init(userEmail: String, name: String, nationalId: String, idUrl: String, photoUrl: String, dateOfBirth: String) {
        self.userEmail = userEmail
        self.name = name
        self.nationalId = nationalId
        self.idUrl = idUrl
        self.photoUrl = photoUrl
        self.dateOfBirth = dateOfBirth
    }
}

public struct VirtualCardCreationRequest: Codable {
    public let userEmail: String
    public let firstName: String
    public let lastName: String
    public let dateOfBirth: String
    public let address: String
    public let postalCode: String
    public let city: String
    public let countryCode: String
    public let state: String
    public let countryPhone: String
    public let phone: String

    enum CodingKeys: String, CodingKey {
        case userEmail = "useremail"
        case firstName = "firstname"
        case lastName = "lastname"
        case dateOfBirth = "dob"
        case address = "address1"
        case postalCode = "postalcode"
        case city
        case countryCode = "countrycode"
        case state
        case countryPhone = "countryphone"
        case phone
    }

    public init(userEmail: String, firstName: String, lastName: String, dateOfBirth: String, address: String, postalCode: String, city: String, countryCode: String, state: String, countryPhone: String, phone: String) {
        self.userEmail = userEmail
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.address = address
        self.postalCode = postalCode
        self.city = city
        self.countryCode = countryCode
        self.state = state
        self.countryPhone = countryPhone
        self.phone = phone
    }
}

public struct DigitalVisaCardCreationRequest: Codable {
    public let userEmail: String
    public let firstName: String
    public let lastName: String

    enum CodingKeys: String, CodingKey {
        case userEmail = "useremail"
        case firstName = "firstname"
        case lastName = "lastname"
    }

    public init(userEmail: String, firstName: String, lastName: String) {
        self.userEmail = userEmail
        self.firstName = firstName
        self.lastName = lastName
    }
}

public struct FundCardRequest: Codable {
    public let userEmail: String
    public let cardId: String
    public let amount: String

    enum CodingKeys: String, CodingKey {
        case userEmail = "useremail"
        case cardId = "cardid"
        case amount
    }

    public init(userEmail: String, cardId: String, amount: String) {
        self.userEmail = userEmail
        self.cardId = cardId
        self.amount = amount
    }
}

public struct ChangePinRequest: Codable {
    public let userEmail: String
    public let cardId: String
    public let newPin: String

    enum CodingKeys: String, CodingKey {
        case userEmail = "useremail"
        case cardId = "cardid"
        case newPin = "pin"
    }

    public init(userEmail: String, cardId: String, newPin: String) {
        self.userEmail = userEmail
        self.cardId = cardId
        self.newPin = newPin
    }
}

// MARK: - Response Models

public struct MessageResponse: Codable {
    public let message: String
}

public struct CardResponse: Codable {
    public let cardId: String?
    public let status: String?
    public let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case cardId = "cardid"
        case status
        case createdAt = "created_at"
    }
}

public struct DigitalVisaCardCreationData: Codable {
    public let id: String
    public let cardName: String
    public let last4Digits: String
    public let currencyCode: String
    public let balance: String
    public let paymentSystem: String
    public let status: String
    public let expiresAt: String
    public let createdAt: String
}

public struct DigitalVisaCardSummary: Codable {
    public let cardId: String
    public let nameOnCard: String
    public let lastFour: String
    public let brand: String
    public let type: String

    enum CodingKeys: String, CodingKey {
        case cardId = "cardid"
        case nameOnCard = "nameoncard"
        case lastFour = "lastfour"
        case brand
        case type
    }
}

public struct DigitalVisaCardDetails: Codable {
    public let cardId: String
    public let nameOnCard: String
    public let cardNumber: String
    public let type: String
    public let brand: String
    public let status: String
    public let expiryYear: String
    public let expiryMonth: String
    public let cvv: String
    public let userEmail: String
    public let balance: String
    public let isAddon: Int
    public let transactions: DigitalVisaTransactionsPage?

    enum CodingKeys: String, CodingKey {
        case cardId = "cardid"
        case nameOnCard = "nameoncard"
        case cardNumber = "card_number"
        case type
        case brand
        case status
        case expiryYear = "expiry_year"
        case expiryMonth = "expiry_month"
        case cvv
        case userEmail = "useremail"
        case balance
        case isAddon = "isaddon"
        case transactions
    }
}

public struct DigitalVisaTransactionsPage: Codable {
    public let data: [DigitalVisaCardTransaction]
    public let total: Int
    public let page: Int
    public let perPage: Int
    public let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case data
        case total
        case page
        case perPage = "per_page"
        case totalPages
    }
}

public struct DigitalVisaCardTransaction: Codable {
    public let transactionId: String?
    public let amount: String?
    public let currency: String?
    public let type: String?
    public let description: String?
    public let timestamp: String?
    public let status: String?

    enum CodingKeys: String, CodingKey {
        case transactionId = "transaction_id"
        case amount
        case currency
        case type
        case description
        case timestamp
        case status
    }
}

public struct DigitalVisaOTPData: Codable {
    public let otp: String?
    public let expiresAt: String?

    enum CodingKeys: String, CodingKey {
        case otp
        case expiresAt = "expires_at"
    }
}

public struct TransactionResponse: Codable {
    public let transactions: [Transaction]?
}

public struct Transaction: Codable {
    public let transactionId: String
    public let amount: String
    public let currency: String
    public let type: String
    public let description: String?
    public let timestamp: String
    public let status: String

    enum CodingKeys: String, CodingKey {
        case transactionId = "transaction_id"
        case amount
        case currency
        case type
        case description
        case timestamp
        case status
    }
}

public struct BalanceResponse: Codable {
    public let balance: String
    public let currency: String?
    public let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case balance
        case currency
        case lastUpdated = "last_updated"
    }
}

public struct Deposit: Codable {
    public let depositId: String
    public let amount: String
    public let currency: String
    public let status: String
    public let createdAt: String

    enum CodingKeys: String, CodingKey {
        case depositId = "deposit_id"
        case amount
        case currency
        case status
        case createdAt = "created_at"
    }
}

public struct LoyaltyPoints: Codable {
    public let balance: String
    public let points: [PointsEntry]?

    public init(balance: String, points: [PointsEntry]? = nil) {
        self.balance = balance
        self.points = points
    }
}

public struct PointsEntry: Codable {
    public let id: Int
    public let cardId: String
    public let balance: String
    public let type: String
    public let details: String
    public let points: String
    public let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case cardId = "cardid"
        case balance
        case type
        case details
        case points
        case createdAt = "created_at"
    }
}

// MARK: - Wallet As A Service Models

public struct Currency: Codable {
    public let symbol: String
    public let name: String
    public let network: String?
}

public struct ExchangeStatus: Codable {
    public let transactionId: String
    public let status: String
    public let amount: Double?
    public let from: String?
    public let to: String?
    public let createdAt: String?
}

public struct ExchangeEstimate: Codable {
    public let estimatedAmount: Double
    public let rate: Double
    public let fee: Double?
}

public struct ExchangeCreateRequest: Codable {
    public let coin_from: String
    public let coin_to: String
    public let network_from: String
    public let network_to: String
    public let deposit_amount: Double
    public let withdrawal: String
    public let withdrawal_extra_id: String?
}

public struct ExchangeCreateResponse: Codable {
    public let transactionId: String
    public let depositAddress: String
    public let amount: Double
    public let status: String
}

public struct WalletAddress: Codable {
    public let uuid: String
    public let address: String
    public let coin: String
    public let useremail: String?
    public let mnemonic: String?
    public let private_key: String?
    public let created_at: String?
}

public struct WalletBalance: Codable {
    public let balances: [String: String]
}

public struct WithdrawalFeeRequest: Codable {
    public let uuid: String
    public let to_address: String
    public let amount: String
    public let coin: String
    public let useremail: String
}

public struct WithdrawalFee: Codable {
    public let fee: String
    public let coin: String
}

public struct WithdrawRequest: Codable {
    public let uuid: String
    public let to_address: String
    public let amount: String
    public let coin: String
    public let useremail: String
    public let memo: String?
}

public struct WithdrawResponse: Codable {
    public let tx_hash: String
    public let status: String
}

public struct WithdrawalStatus: Codable {
    public let status: String
    public let tx_hash: String
    public let coin: String
}
