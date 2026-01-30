---
name: app-architecture
description: iOS app architecture patterns
---

# App Architecture

## Recommended: MVVM + Services

```
App/
├── App.swift              # Entry point
├── Models/                # Data structures
├── Views/                 # SwiftUI views
├── ViewModels/            # Business logic
├── Services/              # API, persistence, etc.
└── Utilities/             # Helpers
```

## Layer Responsibilities

| Layer | Does | Doesn't |
|-------|------|---------|
| View | Display UI, handle gestures | Business logic |
| ViewModel | Transform data, handle actions | UI code, network calls |
| Service | Network, persistence, system APIs | UI, business rules |
| Model | Hold data | Logic |

## ViewModel Pattern

```swift
@Observable
final class FeatureViewModel {
    private let service: FeatureService

    var items: [Item] = []
    var isLoading = false
    var error: Error?

    init(service: FeatureService = .shared) {
        self.service = service
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            items = try await service.fetchItems()
        } catch {
            self.error = error
        }
    }
}
```

## Dependency Injection

```swift
// Protocol for testing
protocol FeatureServiceProtocol {
    func fetchItems() async throws -> [Item]
}

// Real implementation
final class FeatureService: FeatureServiceProtocol {
    static let shared = FeatureService()
    func fetchItems() async throws -> [Item] { ... }
}

// Mock for tests
final class MockFeatureService: FeatureServiceProtocol {
    var mockItems: [Item] = []
    func fetchItems() async throws -> [Item] { mockItems }
}
```
