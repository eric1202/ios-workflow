---
name: optimize-performance
description: Profile and optimize iOS app performance
---

# Optimize Performance Workflow

## Step 1: Identify the Problem

**Ask the user:**

1. What feels slow? (launch, scrolling, specific action)
2. Any specific metrics to hit?

## Step 2: Profile

```bash
# Time Profiler - CPU usage
xcrun xctrace record --template 'Time Profiler' \
    --launch ./build/Build/Products/Debug-iphonesimulator/AppName.app

# Allocations - Memory usage
xcrun xctrace record --template 'Allocations' \
    --launch ./build/Build/Products/Debug-iphonesimulator/AppName.app

# View results
open *.trace
```

## Step 3: Common Optimizations

| Issue | Solution |
|-------|----------|
| Slow launch | Defer non-essential work |
| Scroll jank | Use LazyVStack/LazyHStack |
| Memory growth | Fix retain cycles |
| Large images | Downsample, cache |
| Network waits | Async loading, caching |

## Step 4: Measure After

```bash
# Re-profile to confirm improvement
xcrun xctrace record --template 'Time Profiler' \
    --launch ./build/Build/Products/Debug-iphonesimulator/AppName.app
```

## Step 5: Report

```
Issue: [what was slow]
Cause: [root cause]
Fix: [optimization applied]
Result: [before vs after metrics]
```
