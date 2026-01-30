---
name: testing
description: iOS testing patterns and practices
---

# Testing

## Unit Test Structure

```swift
import XCTest
@testable import AppName

final class ServiceTests: XCTestCase {
    func test_givenInput_whenAction_thenExpected() {
        // Given
        let sut = Service()

        // When
        let result = sut.process("input")

        // Then
        XCTAssertEqual(result, "expected")
    }
}
```

## Async Tests

```swift
func test_asyncOperation() async throws {
    let result = try await service.fetch()
    XCTAssertFalse(result.isEmpty)
}
```

## UI Tests

```swift
func test_loginFlow() {
    let app = XCUIApplication()
    app.launch()

    app.textFields["email"].tap()
    app.textFields["email"].typeText("test@example.com")
    app.buttons["Login"].tap()

    XCTAssertTrue(app.staticTexts["Welcome"].exists)
}
```
