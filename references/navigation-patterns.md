---
name: navigation-patterns
description: iOS navigation patterns with SwiftUI
---

# Navigation Patterns

## NavigationStack (iOS 16+)

```swift
struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List(items) { item in
                NavigationLink(value: item) {
                    Text(item.name)
                }
            }
            .navigationDestination(for: Item.self) { item in
                DetailView(item: item)
            }
        }
    }
}
```

## Tab Navigation

```swift
struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}
```

## Modal Presentation

```swift
struct ParentView: View {
    @State private var showSheet = false

    var body: some View {
        Button("Show") { showSheet = true }
            .sheet(isPresented: $showSheet) {
                SheetView()
            }
    }
}
```
