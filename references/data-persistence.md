---
name: data-persistence
description: Data persistence options for iOS
---

# Data Persistence

## SwiftData (iOS 17+)

```swift
import SwiftData

@Model
final class Item {
    var name: String
    var createdAt: Date

    init(name: String) {
        self.name = name
        self.createdAt = .now
    }
}

// In App
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}

// In View
struct ContentView: View {
    @Query var items: [Item]
    @Environment(\.modelContext) var context

    func addItem() {
        let item = Item(name: "New")
        context.insert(item)
    }
}
```

## UserDefaults (Simple values)

```swift
@AppStorage("username") var username = ""
```

## File Storage

```swift
let url = FileManager.default
    .urls(for: .documentDirectory, in: .userDomainMask)[0]
    .appendingPathComponent("data.json")

// Save
try data.write(to: url)

// Load
let data = try Data(contentsOf: url)
```
