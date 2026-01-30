---
name: storekit
description: In-app purchases with StoreKit 2
---

# StoreKit 2

## Load Products

```swift
import StoreKit

func loadProducts() async throws -> [Product] {
    try await Product.products(for: ["com.app.premium", "com.app.coins"])
}
```

## Purchase

```swift
func purchase(_ product: Product) async throws -> Bool {
    let result = try await product.purchase()

    switch result {
    case .success(let verification):
        let transaction = try checkVerified(verification)
        await transaction.finish()
        return true
    case .userCancelled, .pending:
        return false
    @unknown default:
        return false
    }
}

func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
    switch result {
    case .verified(let item): return item
    case .unverified: throw StoreError.verification
    }
}
```

## Listen for Updates

```swift
func listenForTransactions() -> Task<Void, Error> {
    Task.detached {
        for await result in Transaction.updates {
            let transaction = try self.checkVerified(result)
            await transaction.finish()
        }
    }
}
```
