# App Template

Flutter monorepo template with clean architecture, modular packages, and one-command project initialization.

## Prerequisites

- [FVM](https://fvm.app/) — Flutter version manager
- [Melos](https://melos.invertase.dev/) — monorepo package orchestration
- [Make](https://www.gnu.org/software/make/) — build automation
- [CocoaPods](https://cocoapods.org/) — iOS dependency manager
- [Xcode](https://developer.apple.com/xcode/) — iOS builds
- [Android SDK](https://developer.android.com/studio) — Android builds

## Getting Started

Clone the repo, then run the init script:

```bash
scripts/init.sh
```

The script prompts for an app display name and two bundle IDs (Android and iOS), renames all platform
identifiers across the project, and runs `make init` to bootstrap the workspace.
Run `scripts/init.sh --help` for details.

## Project Structure

```text
apps/
  basic/      # GMS production target (main.dart only)
  debug/      # Debug target with debug screen (main.dart + app.dart)
packages/
  core/       # Environment config, Urls, BuildType, TestEnvDetector
  util/       # Closures, string/iterable extensions
  data/       # Infrastructure (analytics, api, database, location, network, push, storage)
  uikit/      # Reusable UI widget library
  features/   # Feature packages (app, common, debug, device_settings, haptics, splash, theme)
```

Each feature under `packages/features/` follows clean architecture with sub-packages:

- `domain/` — entities, repository interfaces, BLoCs (@freezed events/states)
- `data/` — repository and service implementations
- `di/` — DI scope (yx_scope containers, holders, registrars)
- `presentation/` — UI components, layouts, feature entry

## Architecture Patterns

- **DI (yx_scope)** — Root scope `AppScopeContainer` in `packages/features/app/target/`. Feature scopes
  use `ChildScopeContainer`, `ChildScopeHolder`, and `DependenciesRegistrar` pattern.
- **State Management** — `bloc`/`flutter_bloc` with `@freezed` events and states. BLoCs created in DI
  scopes, provided via `BlocProvider.value`.
- **UI** — `Component<VM, L>` (StatefulWidget + ViewModel) paired with `Layout<VM>` (pure rendering).
  Screens wrapped by `FeatureEntry` for DI scope creation.
- **Routing** — `AppRouter` using `NamedRouteDef` — no code generation. Cross-feature navigation via
  `context.router.pushPath(...)`.

## Make Targets

| Command                 | Description                                               |
|-------------------------|-----------------------------------------------------------|
| `make init`             | Full setup: pub get, codegen, codegen-assets, format      |
| `make get`              | Just `fvm flutter pub get`                                |
| `make codegen`          | Run build_runner across all packages (freezed, etc.)      |
| `make codegen-assets`   | Run fluttergen in `packages/features/app/assets/`         |
| `make intl-with-format` | Regenerate l10n files and format                          |
| `make format`           | Format all packages (line length 120)                     |
| `make test`             | Run all tests                                             |
| `make clean`            | Remove .dart_tool and flutter clean                       |
| `make force-clean`      | Clean + pub cache repair                                  |

### Run Commands

```bash
fvm flutter run --flavor dev -t apps/basic/lib/main.dart   # basic target
fvm flutter run --flavor dev -t apps/debug/lib/main.dart   # debug target
```

## Where Things Go

| I want to...                  | Put it in...                                                                  |
|-------------------------------|-------------------------------------------------------------------------------|
| Add a new feature             | `packages/features/<name>/` with domain/, data/, di/, presentation/ sub-packages |
| Add a new BLoC                | `packages/features/<feature>/domain/` with @freezed events/states            |
| Add a shared UI widget        | `packages/uikit/`                                                             |
| Add an API client             | `packages/data/api/`                                                          |
| Add a utility extension       | `packages/util/`                                                              |
| Add a data sub-package        | `packages/data/<name>/`                                                       |

### Mason Bricks

Templates in `tools/mason/` generate boilerplate:

- **feature** — full feature package with domain/data/di/presentation
- **bloc** — BLoC with @freezed events and states
- **screen** — Component + Layout pair
- **widget** — reusable widget

### New Package

1. Create the package directory under `packages/`
2. Add it to the `workspace:` list in root `pubspec.yaml`
3. Run `make get`
