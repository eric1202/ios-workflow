---
name: performance
description: iOS performance optimization techniques
---

# Performance

## Lazy Loading

```swift
// Use Lazy containers for long lists
LazyVStack {
    ForEach(items) { item in
        ItemRow(item: item)
    }
}
```

## Image Optimization

```swift
// Downsample large images
func downsample(url: URL, to size: CGSize) -> UIImage? {
    let options: [CFString: Any] = [
        kCGImageSourceShouldCache: false,
        kCGImageSourceCreateThumbnailFromImageAlways: true,
        kCGImageSourceThumbnailMaxPixelSize: max(size.width, size.height)
    ]
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, options as CFDictionary)
    else { return nil }
    return UIImage(cgImage: cgImage)
}
```

## Avoid Main Thread Blocking

```swift
// Heavy work off main thread
Task.detached(priority: .userInitiated) {
    let result = heavyComputation()
    await MainActor.run {
        self.data = result
    }
}
```
