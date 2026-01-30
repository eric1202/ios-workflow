---
name: cli-workflow
description: iOS development CLI commands
---

# CLI Workflow

## Build

```bash
# Debug build
xcodebuild -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    build

# Release build
xcodebuild -scheme AppName \
    -configuration Release \
    -destination 'generic/platform=iOS' \
    build
```

## Test

```bash
# All tests
xcodebuild test -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16'

# Specific test
xcodebuild test -scheme AppName \
    -only-testing:AppNameTests/FeatureTests
```

## Simulator

```bash
# List simulators
xcrun simctl list devices

# Boot
xcrun simctl boot "iPhone 16"

# Install
xcrun simctl install booted App.app

# Launch
xcrun simctl launch booted com.company.AppName
```
