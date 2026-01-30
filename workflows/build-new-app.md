---
name: build-new-app
description: Create a new iOS app from scratch using CLI tools
---

# Build New App Workflow

## Step 1: Gather Requirements

**Ask the user:**

1. What is the app name?
2. What does the app do? (one sentence)
3. What's the bundle identifier? (e.g., com.company.appname)
4. Any specific features needed? (e.g., networking, persistence, notifications)

## Step 2: Create Project Structure

```bash
# Create project directory
mkdir -p AppName/AppName/Sources/{App,Views,Models,Services}
mkdir -p AppName/AppName/Resources
mkdir -p AppName/AppNameTests
mkdir -p AppName/AppNameUITests
```

## Step 3: Generate Project Files

### Package.swift (if using SPM)

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "AppName",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "AppName", targets: ["AppName"])
    ],
    targets: [
        .target(name: "AppName", path: "AppName/Sources"),
        .testTarget(name: "AppNameTests", dependencies: ["AppName"])
    ]
)
```

### Xcode Project Generation

```bash
# Use swift package generate-xcodeproj or create manually
# For full iOS app, create .xcodeproj structure:

mkdir -p AppName.xcodeproj
# Generate project.pbxproj with proper targets
```

## Step 4: Create App Entry Point

### AppNameApp.swift

```swift
import SwiftUI

@main
struct AppNameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### ContentView.swift

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, World!")
                .navigationTitle("AppName")
        }
    }
}

#Preview {
    ContentView()
}
```

## Step 5: Configure Info.plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>$(DEVELOPMENT_LANGUAGE)</string>
    <key>CFBundleExecutable</key>
    <string>$(EXECUTABLE_NAME)</string>
    <key>CFBundleIdentifier</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleName</key>
    <string>$(PRODUCT_NAME)</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSRequiresIPhoneOS</key>
    <true/>
    <key>UILaunchScreen</key>
    <dict/>
    <key>UIRequiredDeviceCapabilities</key>
    <array>
        <string>armv7</string>
    </array>
    <key>UISupportedInterfaceOrientations</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
    </array>
</dict>
</plist>
```

## Step 6: Build and Verify

```bash
# Build for simulator
xcodebuild -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    build 2>&1 | xcsift

# Launch in simulator
xcrun simctl boot "iPhone 16" 2>/dev/null || true
xcrun simctl install booted ./build/Build/Products/Debug-iphonesimulator/AppName.app
xcrun simctl launch booted com.company.AppName
```

## Step 7: Report to User

```
Project created: AppName
Structure:
  - AppName/Sources/App/AppNameApp.swift
  - AppName/Sources/Views/ContentView.swift
  - AppName/Resources/Info.plist

Build: ✓
App launches in simulator with "Hello, World!" screen.

Ready for next step. What feature should we add first?
```

## Common Next Steps

After project creation, user typically wants to:

1. **Add data model** → Read `references/data-persistence.md`
2. **Add networking** → Read `references/networking.md`
3. **Design navigation** → Read `references/navigation-patterns.md`
4. **Add UI components** → Read `references/swiftui-patterns.md`
