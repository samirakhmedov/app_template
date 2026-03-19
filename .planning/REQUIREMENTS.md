# Requirements: App Template — Project Initialization Improvements

**Defined:** 2026-03-19
**Core Value:** Running one script turns the template into a new project — asks for app name and bundle ID, renames everything, then you build.

## v1 Requirements

### Init Script

- [x] **INIT-01**: User is prompted for app display name with non-empty validation
- [x] **INIT-02**: User is prompted for bundle ID in reverse-domain format with regex validation and retry on invalid input
- [x] **INIT-03**: Script derives Android (snake_case) and iOS (camelCase) bundle ID variants from a single user input
- [x] **INIT-04**: Script shows a summary of what will change and requires confirmation before writing any files
- [x] **INIT-05**: Script renames bundle ID (namespace, applicationId) and app display name (resValue strings) in Android build.gradle.kts for both basic and debug targets
- [x] **INIT-06**: Script renames bundle ID in iOS common.xcconfig for both basic and debug targets
- [x] **INIT-07**: Script renames display name (CFBundleDisplayName, CFBundleName) in iOS Info.plist for both basic and debug targets
- [x] **INIT-08**: Script renames the name: field in root pubspec.yaml only (not sub-package pubspec.yaml files)
- [x] **INIT-09**: Script moves Android Kotlin source directory from old package path to new path and fixes the package declaration in MainActivity.kt
- [x] **INIT-10**: Script updates package:app_template/ references in Mason brick templates under tools/mason/

### README

- [x] **README-01**: Prerequisites section listing what to install before running init (FVM, Melos, CocoaPods, Make, Xcode, Android SDK)
- [x] **README-02**: Init script instructions explaining how to run scripts/init.sh and what it does
- [x] **README-03**: Monorepo layout diagram showing apps/ and packages/ structure with one-line descriptions
- [x] **README-04**: Key make targets reference (init, codegen, format, test, and run commands per app target)
- [x] **README-05**: Where-things-go guide explaining which package/layer to put new code in and how to use Mason bricks

## v2 Requirements

### Init Script

- **INIT-V2-01**: Auto-run make init (fvm install, pub get, melos bootstrap, codegen) at end of script
- **INIT-V2-02**: Idempotency guard — detect if already initialized and warn/exit
- **INIT-V2-03**: Dry-run mode (--dry-run flag) to preview changes without writing

### README

- **README-V2-01**: Secrets setup section (what goes in secrets/, how propagate_secrets.sh works)
- **README-V2-02**: Mason brick quick reference (how to use each brick, args)

## Out of Scope

| Feature | Reason |
|---------|--------|
| Huawei/HMS target in init script | User explicitly excluded Huawei from new projects |
| Firebase/google-services.json stub generation | Not selected; requires real Firebase project config |
| Deep architecture documentation | CLAUDE.md owns this; README stays quick-start focused |
| `flutter pub run rename` package | Requires pub get first; incompatible with flavor setup |
| Automatic git remote removal | Destructive; user should decide when to detach from origin |
| Open-source / multi-dev onboarding docs | Personal use only |

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| INIT-01 | Phase 1 | Complete |
| INIT-02 | Phase 1 | Complete |
| INIT-03 | Phase 1 | Complete |
| INIT-04 | Phase 1 | Complete |
| INIT-05 | Phase 2 | Complete |
| INIT-06 | Phase 2 | Complete |
| INIT-07 | Phase 2 | Complete |
| INIT-08 | Phase 2 | Complete |
| INIT-09 | Phase 2 | Complete |
| INIT-10 | Phase 2 | Complete |
| README-01 | Phase 3 | Complete |
| README-02 | Phase 3 | Complete |
| README-03 | Phase 3 | Complete |
| README-04 | Phase 3 | Complete |
| README-05 | Phase 3 | Complete |

**Coverage:**
- v1 requirements: 15 total
- Mapped to phases: 15
- Unmapped: 0 ✓

---
*Requirements defined: 2026-03-19*
*Last updated: 2026-03-19 after roadmap creation — phase assignments updated*
