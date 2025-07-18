# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Core Commands
- **Run app**: `fvm flutter run` (requires FVM for Flutter version management)
- **Install dependencies**: `fvm flutter pub get`
- **Code generation**: `make codegen` (runs build_runner, formats code)
- **Format code**: `make format` (formats with 100 character line length)
- **Clean build**: `make clean` (removes .dart_tool, .pubspec_lock, runs flutter clean)

### Code Generation Commands
- **All packages**: `make codegen`
- **Database only**: `make codegen-db`
- **UIKit only**: `make codegen-uikit`
- **API only**: `make codegen-api`
- **Assets only**: `make codegen-assets`

### Testing Commands
- **Reset golden files**: `make reset-goldens`
- **Tests**: Standard Flutter test commands (`fvm flutter test`)

### Localization
- **Generate localization**: `make intl-with-format`
- **Localization files**: Located in `assets/resources/bundles/`

### Build and Deployment
- **iOS builds**: `make ios-qa-dev-deploy`, `make ios-prod-deploy`
- **Android builds**: `make android-qa-dev-deploy`, `make android-prod-deploy`
- **Propagate secrets**: `make propagate-secrets`

## Architecture Overview

### Core Principles
This Flutter project follows **Clean Architecture** with **feature-based modularity**:

1. **Feature-based structure**: Each feature lives in `lib/features/[feature_name]/`
2. **Layered architecture**: Each feature has `data/`, `domain/`, and `presentation/` layers
3. **Dependency rule**: Dependencies flow inwards (Presentation → Domain → Data)
4. **Dependency injection**: Uses `yx_scope` package with hierarchical scopes
5. **Local packages**: Shared functionality extracted to `packages/` directory

### Layer Structure
- **Presentation Layer**:
  - `*_entry.dart`: Route entry point with `@RoutePage`, sets up DI scope
  - `*_component.dart`: `StatefulWidget` with business logic, interacts with BLoC
  - `*_layout.dart`: "Dumb" `StatelessWidget` for UI rendering
  - `ViewModel` interface contracts between Component and Layout

- **Domain Layer**:
  - `*_bloc.dart`: State management using BLoC pattern
  - Entities: Immutable business objects (typically using `freezed`)
  - Repository interfaces: `i_*_repository.dart`

- **Data Layer**:
  - Repository implementations
  - Services: `i_*_service.dart` and `*_service.dart`
  - Converters: Transform data between formats

### Dependency Injection
- **AppScope**: Central application-wide dependencies (`lib/features/app/di/app_scope.dart`)
- **Feature scopes**: Child scopes inheriting from AppScope
- **Access pattern**: `context.read<ISomeScope>()`

### Local Packages Architecture
- **`packages/uikit/`**: Shared UI components, themes, widgets
- **`packages/database/`**: Database layer using Drift
- **`packages/network/`**: HTTP client with Dio
- **`packages/storage/`**: Storage abstraction
- **`packages/api/`**: API service definitions
- **`packages/haptics/`**: Custom haptic feedback
- **Service packages**: `analytics/`, `push/`, `location/` with GMS/HMS implementations

## Code Style and Patterns

### Key Conventions
- **Interfaces**: Use `abstract interface class` for all interfaces
- **Async operations**: Wrap fallible operations in `makeCall` from `lib/core/data/repositories/base_repository.dart`
- **Return types**: Use `RequestOperation<T>` for async operations that may fail
- **State management**: BLoC pattern throughout
- **Immutability**: Use `freezed` for immutable classes and `copyWith` pattern
- **Private members**: Use leading underscore `_`
- **Modern Dart**: Use Dart 3 syntax with enum constructors and sealed classes
- **Asset Management**: Use `flutter_gen` for type-safe asset access
- **Import Style**: Use `package:app_template/` imports, not relative imports

### Error Handling
- **Result pattern**: Use `Result<T, E>` for success/failure states
- **BaseRepository**: Consistent error handling via `makeCall`
- **RequestOperation**: Type alias for async operations

## Code Generation Tools

### Mason Templates
- **Location**: `tools/mason/`
- **Available templates**: features, blocs, screens, widgets
- **Usage**: Follow Mason documentation for generating boilerplate code

### Build Runner
- **Freezed**: Generates immutable classes, unions, copyWith methods
- **Auto Route**: Generates routing code
- **Drift**: Database code generation
- **Retrofit**: API client generation
- **Flutter Gen**: Generates type-safe asset access classes

## Key Files for Context

When working on features, always include these files for context:

### Core Architecture
- `lib/core/architecture/presentation/component.dart`
- `lib/core/architecture/presentation/layout.dart`
- `lib/core/architecture/data/repositories/base_repository.dart`
- `lib/core/architecture/domain/entity/request_operation.dart`
- `lib/core/architecture/di/disposable.dart` (LifecycleObject interface)

### App Configuration
- `lib/features/app/di/app_scope.dart`
- `lib/features/app/di/app_scope_container.dart`
- `lib/features/app/di/app_scope_registrar.dart`
- `lib/generated/assets.gen.dart` (Flutter Gen asset references)
- `pubspec.yaml`

### UI Kit
- `packages/uikit/pubspec.yaml`
- `packages/uikit/lib/src/theme/app_theme.dart`
- `packages/uikit/lib/src/widgets/**`

### Feature-specific
- Include all files within the feature directory when working on a specific feature

## Multi-Platform Support

This project supports:
- **Android**: Standard Flutter Android with flavors
- **iOS**: iOS with secure enclave integration
- **Aurora**: Aurora OS support
- **HarmonyOS**: HarmonyOS support

## Development Workflow

1. **Setup**: Install FVM, run `fvm install`, then `fvm flutter pub get`
2. **Code generation**: Run `make codegen` after adding new models/APIs
3. **Development**: Use `fvm flutter run` for development
4. **Testing**: Run tests, update golden files when needed
5. **Formatting**: Code is automatically formatted to 100 characters per line
6. **Deployment**: Use appropriate make commands for platform-specific builds

## Important Notes

- Always use FVM for Flutter version management
- Run code generation after adding new models, APIs, or database schemas
- Follow the established architectural patterns for consistency
- Use the provided Mason templates for new features
- Respect the dependency injection hierarchy
- All asynchronous operations in repositories must use `makeCall` for error handling

## Feature Folder Structure

### Standard Feature Organization
```
lib/features/[feature_name]/
├── data/
│   ├── repositories/          # Repository implementations
│   │   └── feature_repository.dart
│   └── services/             # Service interfaces and implementations
│       ├── i_feature_service.dart
│       └── feature_service.dart
├── domain/
│   ├── entities/             # Business entities and enums
│   │   ├── feature_entity.dart
│   │   └── feature_type.dart
│   └── repositories/         # Repository interfaces
│       └── i_feature_repository.dart
└── presentation/
    ├── state/
    │   └── [feature_name]/            # BLoC state management
    │       ├── feature_bloc.dart
    │       └── feature_bloc.freezed.dart
    └── widgets|screens/             # UI components
        ├── root/
              └── feature_entry.dart
        ├── feature_component.dart
        └── feature_layout.dart
```

### Common Feature Organization
- **Common entities**: `lib/features/common/domain/entities/`
- **Common repositories**: `lib/features/common/domain/repositories/`
- **Common services**: `lib/features/common/data/services/`
- **Common BLoCs**: `lib/features/common/presentation/state/bloc/`
- **Common widgets**: `lib/features/common/presentation/widgets/`

## BLoC Pattern Implementation

### Event and State Structure
- **Events**: Use `@freezed sealed class` with factory constructors
- **States**: Use `@freezed class` with `@Default()` annotations
- **Naming**: Use descriptive action-oriented names (e.g., `initialize`, `loadShader`)
- **Private Events**: Use leading underscore for internal events (e.g., `_updateState`)

### BLoC Lifecycle Management
- **Repository Integration**: Access repositories through dependency injection
- **ValueListenable**: Use `addListener`/`removeListener` for reactive updates
- **Cleanup**: Override `close()` method to dispose of listeners and resources
- **Error Handling**: Let repositories handle errors via `RequestOperation<T>`

### Modern Freezed Patterns
```dart
@freezed
sealed class MyEvent with _$MyEvent {
  const factory MyEvent.initialize() = MyInitialize;
  const factory MyEvent.loadData(String id) = MyLoadData;
  const factory MyEvent._updateState(List<Item> items) = _MyUpdateState;
}

@freezed
class MyState with _$MyState {
  const factory MyState({
    @Default([]) List<Item> items,
    @Default(false) bool isLoading,
  }) = _MyState;
}
```

## Service and Repository Implementation

### Service Pattern
- **Interface**: Extend `LifecycleObject` for services requiring initialization/disposal
- **Implementation**: Place in `data/services/` folder
- **State Management**: Use `ValueListenable` for reactive state exposure
- **Lifecycle**: Implement `initialize()` and `dispose()` methods
- **Error Handling**: Let exceptions bubble up to repository layer

### Repository Pattern
- **Interface**: Place in `domain/repositories/` folder
- **Implementation**: Place in `data/repositories/` folder, extend `BaseRepository`
- **Error Handling**: Wrap all fallible operations in `makeCall()`
- **Return Types**: Use `RequestOperation<T>` for async operations that may fail
- **State Access**: Expose `ValueListenable` directly from services
- **Dependencies**: Accept service interfaces through constructor injection

### Entity and Enum Patterns
- **Location**: Place in `domain/entities/` folder
- **Entities**: Use `@freezed` for immutable data classes
- **Enums**: Use modern Dart 3 syntax with constructor parameters
- **Constants**: Use `abstract final class` for static constants
- **Documentation**: Add dartdoc comments for all public members