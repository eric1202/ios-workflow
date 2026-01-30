---
name: ci-cd
description: CI/CD setup for iOS apps
---

# CI/CD

## GitHub Actions

```yaml
name: iOS Build
on: [push]

jobs:
  build:
    runs-on: macos-14
    steps:
      - uses: actions/checkout@v4

      - name: Build
        run: |
          xcodebuild -scheme AppName \
            -destination 'platform=iOS Simulator,name=iPhone 16' \
            build

      - name: Test
        run: |
          xcodebuild test -scheme AppName \
            -destination 'platform=iOS Simulator,name=iPhone 16'
```

## Fastlane (Optional)

```ruby
lane :beta do
  build_app(scheme: "AppName")
  upload_to_testflight
end
```
