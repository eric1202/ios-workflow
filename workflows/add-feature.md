---
name: add-feature
description: Add features to existing iOS apps
---

# Add Feature Workflow

## Step 1: Understand the Feature

**Ask the user:**

1. What should the feature do?
2. Where should it appear in the app?
3. Any specific UI requirements?
4. Does it need data persistence or networking?

## Step 2: Plan the Implementation

1. Identify affected files
2. Determine new files needed
3. Check if references needed (networking, persistence, etc.)
4. Outline test cases

## Step 3: Implement in Small Steps

```
For each component:
1. Write the code
2. Build to verify syntax
3. Write test if logic-heavy
4. Run tests
5. Report progress
```

## Step 4: Verification Loop

```bash
# After each change
xcodebuild -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    build 2>&1 | xcsift

# Run tests
xcodebuild -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    test

# Visual verification
xcrun simctl launch booted com.company.AppName
```

## Step 5: Report to User

```
Feature: [name]
Added:
  - [file1]: [what it does]
  - [file2]: [what it does]
Modified:
  - [file3]: [what changed]

Build: ✓
Tests: X pass, 0 fail
Ready for you to test [specific interaction]
```
