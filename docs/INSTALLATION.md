# BSICARDS iOS SDK - Installation Guide

## System Requirements

- **iOS**: 13.0+
- **Swift**: 5.5+
- **Xcode**: 12.0+

## Installation Methods

### Method 1: CocoaPods (Recommended)

Add to your `Podfile`:

```ruby
pod 'BSICards', '~> 1.0.0'
```

Then run:

```bash
pod install
```

### Method 2: Swift Package Manager

1. In Xcode: File → Add Packages
2. Enter repository URL: `https://github.com/nash81/bsicards-ios-sdk.git`
3. Select version: Up to Next Major (1.0.0)
4. Add to your target

### Method 3: Manual Integration

1. Clone the repository
2. Drag `Sources/BSICards` folder into your Xcode project
3. Ensure `Copy items if needed` is selected

## Configuration

### Step 1: Add Permissions

Add to your `Info.plist`:

```xml
<key>NSLocalNetworkUsageDescription</key>
<string>This app needs to communicate with BSICARDS API</string>
```

### Step 2: Store Credentials

**Option A: Environment Variables (Development)**

In your Xcode scheme:
1. Edit Scheme → Run → Arguments
2. Add environment variables:
   - `BSICARDS_PUBLIC_KEY` = your_public_key
   - `BSICARDS_SECRET_KEY` = your_secret_key

**Option B: Keychain (Production - Recommended)**

```swift
import Security

func storeCredentials() {
    let publicKey = "your_public_key"
    let secretKey = "your_secret_key"

    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "bsicards_public_key",
        kSecValueData as String: publicKey.data(using: .utf8)!
    ]

    SecItemAdd(query as CFDictionary, nil)
}

func retrievePublicKey() -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "bsicards_public_key",
        kSecReturnData as String: true
    ]

    var result: AnyObject?
    SecItemCopyMatching(query as CFDictionary, &result)

    if let data = result as? Data {
        return String(data: data, encoding: .utf8)
    }
    return nil
}
```

### Step 3: Initialize the Client

```swift
import BSICards

// In your AppDelegate or SceneDelegate
let client = BSICardsClient(
    publicKey: "your_public_key",
    secretKey: "your_secret_key"
)
```

Or with environment variables:

```swift
let client = BSICardsClient() // Auto-reads from environment
```

## Verify Installation

Create a test view to verify setup:

```swift
import SwiftUI
import BSICards

struct ContentView: View {
    @State private var status = "Testing..."
    private let client = BSICardsClient()

    var body: some View {
        VStack {
            Text(status)
                .padding()
        }
        .onAppear {
            Task {
                do {
                    let publicKey = client.getPublicKey()
                    if !publicKey.isEmpty {
                        status = "✓ SDK initialized successfully!"
                    } else {
                        status = "✗ Missing API credentials"
                    }
                } catch {
                    status = "✗ Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
```

## Troubleshooting

### "Module not found" Error

1. Ensure framework is added to target:
   - Target Settings → Build Phases → Link Binary With Libraries
   - Add BSICards framework

2. Check import statement:
   ```swift
   import BSICards
   ```

### "Invalid Credentials" Error

Verify credentials are set:
```swift
let client = BSICardsClient()
print("Public Key: \(client.getPublicKey())")
print("Secret Key: \(client.getSecretKey())")
```

### Network Timeout

Check:
1. Internet connection is active
2. API endpoint is reachable
3. Firewall allows HTTPS traffic

### Decoding Errors

Ensure your `Info.plist` doesn't have strict policies:
```xml
<key>NSLocalNetworkUsageDescription</key>
<string>BSICARDS API communication</string>
```

## Next Steps

1. Read [README.md](../README.md) for API overview
2. Check [EXAMPLES.md](./EXAMPLES.md) for code samples
3. Review [API.md](./API.md) for endpoint documentation

## Getting Help

- Email: cs@bsigroup.tech
- Website: https://www.bsigroup.tech
- GitHub: https://github.com/nash81/bsicards-ios-sdk

