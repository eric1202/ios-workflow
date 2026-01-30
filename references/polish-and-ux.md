---
name: polish-and-ux
description: UI polish and UX best practices
---

# Polish and UX

## Haptic Feedback

```swift
// Impact
UIImpactFeedbackGenerator(style: .medium).impactOccurred()

// Selection
UISelectionFeedbackGenerator().selectionChanged()

// Notification
UINotificationFeedbackGenerator().notificationOccurred(.success)
```

## Animations

```swift
// Implicit
withAnimation(.spring(duration: 0.3)) {
    isExpanded.toggle()
}

// Explicit
Text("Hello")
    .scaleEffect(isPressed ? 0.95 : 1.0)
    .animation(.easeInOut(duration: 0.1), value: isPressed)
```

## Loading States

```swift
struct LoadingButton: View {
    let isLoading: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
            } else {
                Text("Submit")
            }
        }
        .disabled(isLoading)
    }
}
```
