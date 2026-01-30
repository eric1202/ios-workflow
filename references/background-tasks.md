---
name: background-tasks
description: Background task handling for iOS
---

# Background Tasks

## BGTaskScheduler

```swift
import BackgroundTasks

// Register in App init
BGTaskScheduler.shared.register(
    forTaskWithIdentifier: "com.app.refresh",
    using: nil
) { task in
    handleRefresh(task as! BGAppRefreshTask)
}

// Schedule
func scheduleRefresh() {
    let request = BGAppRefreshTaskRequest(identifier: "com.app.refresh")
    request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
    try? BGTaskScheduler.shared.submit(request)
}

// Handle
func handleRefresh(_ task: BGAppRefreshTask) {
    scheduleRefresh() // Reschedule

    let operation = RefreshOperation()
    task.expirationHandler = { operation.cancel() }

    operation.completionBlock = {
        task.setTaskCompleted(success: !operation.isCancelled)
    }
    OperationQueue().addOperation(operation)
}
```

## Info.plist

```xml
<key>BGTaskSchedulerPermittedIdentifiers</key>
<array>
    <string>com.app.refresh</string>
</array>
```
