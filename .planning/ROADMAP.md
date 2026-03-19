# Roadmap: App Template — Project Initialization Improvements

## Overview

Three sequential phases transform the template into a one-command initialization experience. Phase 1 establishes the user-facing input pipeline (prompts, validation, confirmation) without touching any files. Phase 2 applies all platform-specific renames atomically — Android, iOS, Dart, Mason — then runs the bootstrap sequence. Phase 3 writes the README that documents what Phase 2 produces. Each phase depends on the prior one being stable before beginning.

## Phases

**Phase Numbering:**
- Integer phases (1, 2, 3): Planned milestone work
- Decimal phases (2.1, 2.2): Urgent insertions (marked with INSERTED)

Decimal phases appear between their surrounding integers in numeric order.

- [x] **Phase 1: Script Input Pipeline** - Runnable init script that prompts, validates, and shows confirmation summary — no file mutations yet (completed 2026-03-19)
- [ ] **Phase 2: File Rename Implementation** - All platform renames (Android, iOS, Dart, Mason) applied atomically, followed by bootstrap
- [x] **Phase 3: README** - Updated README.md with prerequisites, init instructions, monorepo layout, make targets, and where-things-go guide (completed 2026-03-19)

## Phase Details

### Phase 1: Script Input Pipeline
**Goal**: Users can run `scripts/init.sh` and receive guided, validated prompts for app name and bundle ID, with a clear confirmation summary before anything is written
**Depends on**: Nothing (first phase)
**Requirements**: INIT-01, INIT-02, INIT-03, INIT-04
**Success Criteria** (what must be TRUE):
  1. Running `scripts/init.sh` prompts for app display name and rejects empty input with a clear message
  2. Bundle ID prompt validates reverse-domain format (e.g. `com.example.myapp`) and loops on invalid input without exiting
  3. After valid input, the script prints a summary table showing what will change (old values vs new values) and asks for explicit confirmation
  4. User can abort at the confirmation step and no files are modified
  5. The script derives correct Android (snake_case) and iOS (camelCase) bundle ID variants automatically from a single user input
**Plans**: 1 plan

Plans:
- [x] 01-01-PLAN.md — Create init.sh interactive CLI with prompts, validation, summary, confirmation, and bats tests

### Phase 2: File Rename Implementation
**Goal**: After confirmation, all platform-specific identifiers are correctly renamed across every target file and the workspace bootstraps successfully under the new name
**Depends on**: Phase 1
**Requirements**: INIT-05, INIT-06, INIT-07, INIT-08, INIT-09, INIT-10
**Success Criteria** (what must be TRUE):
  1. Android `build.gradle.kts` in both basic and debug targets reflects new namespace, applicationId, and app_name resValue
  2. iOS `common.xcconfig` in both basic and debug targets reflects new bundle ID, and the project builds without xcconfig conflicts
  3. iOS `Info.plist` in both basic and debug targets shows the new CFBundleDisplayName and CFBundleName
  4. The Android Kotlin source directory is moved from the old package path to the new path and `MainActivity.kt` package declaration matches
  5. Root `pubspec.yaml` `name:` field is updated and Mason brick templates in `tools/mason/` no longer reference `package:app_template/`
**Plans**: 2 plans

Plans:
- [ ] 02-01-PLAN.md — TDD: Implement all rename functions in init.sh with bats tests (INIT-05 through INIT-10)
- [ ] 02-02-PLAN.md — Human verification of full interactive rename flow on real project files

### Phase 3: README
**Goal**: The project README accurately describes how to initialize the template and where everything goes, so a developer can go from clone to running project without guessing
**Depends on**: Phase 2
**Requirements**: README-01, README-02, README-03, README-04, README-05
**Success Criteria** (what must be TRUE):
  1. A developer who has never seen the repo can identify every prerequisite to install before running `scripts/init.sh`
  2. The README explains what `scripts/init.sh` does and how to run it in one section
  3. The monorepo layout is visible as a diagram with one-line descriptions of `apps/` and `packages/`
  4. All key `make` targets (init, codegen, format, test, and per-target run commands) are listed in one reference section
  5. A where-things-go guide tells a developer which package and layer to place new code in and how to use Mason bricks
**Plans**: 1 plan

Plans:
- [ ] 03-01-PLAN.md — Write complete README.md with all sections and human-verify

## Progress

**Execution Order:**
Phases execute in numeric order: 1 → 2 → 3

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Script Input Pipeline | 1/1 | Complete   | 2026-03-19 |
| 2. File Rename Implementation | 0/2 | Planning complete | - |
| 3. README | 1/1 | Complete   | 2026-03-19 |
