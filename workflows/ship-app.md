---
name: ship-app
description: Ship iOS apps to TestFlight and App Store
---

# Ship App Workflow

## Step 1: Pre-flight Check

```bash
# Verify build succeeds
xcodebuild -scheme AppName \
    -destination 'generic/platform=iOS' \
    -configuration Release \
    build 2>&1 | xcsift

# Run all tests
xcodebuild -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    test
```

## Step 2: Archive

```bash
xcodebuild -scheme AppName \
    -destination 'generic/platform=iOS' \
    -configuration Release \
    -archivePath ./build/AppName.xcarchive \
    archive
```

## Step 3: Export IPA

```bash
# Create ExportOptions.plist first
xcodebuild -exportArchive \
    -archivePath ./build/AppName.xcarchive \
    -exportPath ./build/export \
    -exportOptionsPlist ExportOptions.plist
```

## Step 4: Upload

```bash
# Upload to App Store Connect
xcrun altool --upload-app \
    -f ./build/export/AppName.ipa \
    -t ios \
    -u "apple-id@email.com" \
    -p "@keychain:AC_PASSWORD"

# Or use newer notarytool
xcrun notarytool submit ./build/export/AppName.ipa \
    --apple-id "email" \
    --team-id "TEAM_ID" \
    --password "@keychain:AC_PASSWORD"
```

## Step 5: Report

```
Version: X.Y.Z (Build N)
Archive: ✓
Export: ✓
Upload: ✓
Status: Processing on App Store Connect
```
