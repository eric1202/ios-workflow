---
name: debug-app
description: Find and fix bugs in iOS apps using CLI tools
---

# Debug App Workflow

## Step 1: Understand the Problem

**Ask the user:**

1. What's happening? (crash, wrong behavior, UI issue)
2. When does it happen? (always, sometimes, specific action)
3. Any error messages visible?
4. Did it work before? What changed?

## Step 2: Reproduce the Issue

```bash
# Build and run
xcodebuild -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    build 2>&1 | xcsift

# Launch and observe
xcrun simctl boot "iPhone 16" 2>/dev/null || true
xcrun simctl install booted ./build/Build/Products/Debug-iphonesimulator/AppName.app
xcrun simctl launch booted com.company.AppName

# Watch logs
xcrun simctl spawn booted log stream --predicate 'subsystem == "com.company.AppName"'
```

## Step 3: Diagnose by Type

### Crash

```bash
# Check crash logs
xcrun simctl spawn booted log show --predicate 'eventMessage contains "crash"' --last 5m

# Symbolicate if needed
xcrun atos -arch arm64 -o AppName.app/AppName -l 0x100000000 0x100001234
```

### Memory Issues

```bash
# Check for leaks
xcrun leaks --atExit -- ./AppName.app/AppName

# Memory graph
xcrun simctl spawn booted leaks AppName
```

### Performance

```bash
# CPU/Memory sampling
xcrun xctrace record --template 'Time Profiler' --launch AppName.app
```

## Step 4: Fix and Verify

1. Make minimal change to fix the issue
2. Build and test:

```bash
xcodebuild -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    test 2>&1 | xcsift
```

3. Verify fix in simulator
4. Confirm no regressions

## Step 5: Report to User

```
Bug: [description]
Cause: [root cause found]
Fix: [what was changed]
Verification:
  - Build: ✓
  - Tests: X pass, 0 fail
  - Manual test: [specific verification done]
```

## Common Bug Patterns

| Symptom | Likely Cause | Check |
|---------|--------------|-------|
| Crash on launch | Missing resource, nil unwrap | Console logs |
| UI not updating | State not published | @Published, @State |
| Memory growing | Retain cycle | weak self in closures |
| Network fails | Missing permissions | Info.plist, ATS |
