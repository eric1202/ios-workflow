---
name: accessibility
description: iOS accessibility best practices
---

# Accessibility

## Labels

```swift
Image(systemName: "heart.fill")
    .accessibilityLabel("Favorite")

Button(action: delete) {
    Image(systemName: "trash")
}
.accessibilityLabel("Delete item")
```

## Traits

```swift
Text("Section Title")
    .accessibilityAddTraits(.isHeader)

Button("Submit")
    .accessibilityAddTraits(.isButton)
```

## Dynamic Type

```swift
Text("Body text")
    .font(.body) // Automatically scales

// Custom font with scaling
@ScaledMetric var iconSize = 24.0
Image(systemName: "star")
    .frame(width: iconSize, height: iconSize)
```

## Reduce Motion

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

withAnimation(reduceMotion ? nil : .spring()) {
    // animate
}
```
