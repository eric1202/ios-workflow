---
name: push-notifications
description: Push notifications setup for iOS
---

# Push Notifications

## Request Permission

```swift
import UserNotifications

func requestPermission() async -> Bool {
    do {
        return try await UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound])
    } catch {
        return false
    }
}
```

## Register for Remote

```swift
// In AppDelegate or App init
UIApplication.shared.registerForRemoteNotifications()

// Handle token
func application(_ app: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken token: Data) {
    let tokenString = token.map { String(format: "%02.2hhx", $0) }.joined()
    // Send to server
}
```

## Local Notification

```swift
func scheduleLocal() {
    let content = UNMutableNotificationContent()
    content.title = "Reminder"
    content.body = "Check the app"

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
    let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request)
}
```
