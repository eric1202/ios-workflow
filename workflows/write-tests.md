---
name: write-tests
description: Write and run tests for iOS apps
---

# Write Tests Workflow

## Step 1: Identify What to Test

**Ask the user:**

1. What needs testing? (specific feature, whole app, bug fix)
2. Unit tests, UI tests, or both?

## Step 2: Test Structure

```
AppNameTests/
├── Models/
│   └── UserTests.swift
├── Services/
│   └── APIServiceTests.swift
└── ViewModels/
    └── HomeViewModelTests.swift
```

## Step 3: Write Unit Tests

```swift
import XCTest
@testable import AppName

final class FeatureTests: XCTestCase {

    var sut: Feature!  // System Under Test

    override func setUp() {
        super.setUp()
        sut = Feature()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_givenCondition_whenAction_thenResult() {
        // Given
        let input = "test"

        // When
        let result = sut.process(input)

        // Then
        XCTAssertEqual(result, "expected")
    }
}
```

## Step 4: Run Tests

```bash
# Run all tests
xcodebuild -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    test 2>&1 | xcsift

# Run specific test
xcodebuild -scheme AppName \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    -only-testing:AppNameTests/FeatureTests \
    test
```

## Step 5: Report Results

```
Tests written: X new tests
Coverage: [area covered]
Results: X pass, 0 fail
```
