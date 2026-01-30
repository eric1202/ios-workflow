---
name: app-store
description: App Store submission guidelines
---

# App Store

## Pre-submission Checklist

- [ ] App icon (1024x1024)
- [ ] Screenshots (6.7", 6.5", 5.5" iPhones)
- [ ] App description
- [ ] Privacy policy URL
- [ ] Support URL

## CLI Upload

```bash
# Validate
xcrun altool --validate-app -f App.ipa -t ios

# Upload
xcrun altool --upload-app -f App.ipa -t ios \
    -u "email" -p "@keychain:AC_PASSWORD"
```

## Common Rejections

| Issue | Fix |
|-------|-----|
| Crash on launch | Test on real device |
| Missing privacy | Add usage descriptions |
| Incomplete metadata | Fill all fields |
| Placeholder content | Remove lorem ipsum |
