---
name: swiftui-patterns
description: Common SwiftUI patterns and best practices
---

# SwiftUI Patterns

## State Management

```swift
// Local state
@State private var count = 0

// Observable object (iOS 17+)
@Observable class ViewModel { }

// Environment
@Environment(\.dismiss) var dismiss
```

## Common View Patterns

### List with Loading

```swift
struct ItemListView: View {
    @State private var viewModel = ItemViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.items) { item in
                    ItemRow(item: item)
                }
            }
        }
        .task { await viewModel.load() }
    }
}
```

### Form Input

```swift
struct FormView: View {
    @State private var name = ""
    @State private var email = ""

    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            Button("Submit") { submit() }
                .disabled(name.isEmpty || email.isEmpty)
        }
    }
}
```

## Performance Tips

- Use `LazyVStack` / `LazyHStack` for long lists
- Use `@ViewBuilder` for conditional content
- Avoid heavy computation in `body`
- Use `.task` instead of `.onAppear` for async
