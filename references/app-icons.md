---
name: app-icons
description: App icon setup for iOS
---

# App Icons

## Required Sizes

| Size | Usage |
|------|-------|
| 1024x1024 | App Store |
| 180x180 | iPhone @3x |
| 120x120 | iPhone @2x |
| 167x167 | iPad Pro |
| 152x152 | iPad |

## Generate via CLI

```bash
# Using sips (built-in macOS)
sips -z 1024 1024 icon.png --out AppIcon1024.png
sips -z 180 180 icon.png --out AppIcon180.png
sips -z 120 120 icon.png --out AppIcon120.png
```

## Asset Catalog Structure

```
Assets.xcassets/
└── AppIcon.appiconset/
    ├── Contents.json
    ├── icon-1024.png
    ├── icon-180.png
    └── icon-120.png
```
