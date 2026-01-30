---
name: cli-observability
description: CLI tools for debugging and monitoring iOS apps
---

# CLI Observability

## Logs

```bash
# Stream logs
xcrun simctl spawn booted log stream \
    --predicate 'subsystem == "com.company.AppName"'

# Show recent logs
xcrun simctl spawn booted log show --last 5m
```

## Memory

```bash
# Check for leaks
xcrun leaks AppName

# Memory footprint
xcrun simctl spawn booted footprint AppName
```

## Profiling

```bash
# Record trace
xcrun xctrace record --template 'Time Profiler' \
    --launch App.app

# List templates
xcrun xctrace list templates
```
