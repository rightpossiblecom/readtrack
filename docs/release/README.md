# ReadTrack Release Credentials

## Keystore Details

| Field | Value |
|-------|-------|
| File | `readtrack-release.jks` |
| Key Alias | `readtrack` |
| Store Password | `readtrack123` |
| Key Password | `readtrack123` |
| Validity | 10,000 days |

## Package Info

| Field | Value |
|-------|-------|
| App Name | ReadTrack |
| Package ID | `com.readtrack.app` |
| Version | 1.0.0+1 |
| Website | https://readtrack.vercel.app |
| Support Email | support@readtrack.app |
| Privacy Policy | https://readtrack.vercel.app/privacy |

## Critical: Keystore Backup

The keystore file `readtrack-release.jks` is stored here and also at `android/app/readtrack-release.jks`.

⚠️ NEVER lose the keystore. Without it you cannot push updates to the Play Store.

## Build Commands

```bash
# Generate icons
flutter pub run flutter_launcher_icons

# Generate splash
flutter pub run flutter_native_splash:create

# Release bundle
flutter build appbundle --release
```

Output AAB: `build/app/outputs/bundle/release/app-release.aab`
