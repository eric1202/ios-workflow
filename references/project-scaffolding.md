---
name: project-scaffolding
description: iOS project structure and setup
---

# Project Scaffolding

## Directory Structure

```
AppName/
├── AppName.xcodeproj/
├── AppName/
│   ├── Sources/
│   │   ├── App/
│   │   │   └── AppNameApp.swift
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   ├── Models/
│   │   └── Services/
│   └── Resources/
│       ├── Assets.xcassets/
│       └── Info.plist
├── AppNameTests/
└── AppNameUITests/
```

## Minimum Files

1. `AppNameApp.swift` - Entry point
2. `ContentView.swift` - Root view
3. `Info.plist` - App configuration
4. `Assets.xcassets` - Images and colors
