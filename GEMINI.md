# AI Tooling Rules and Project Architecture Guide

This document provides a comprehensive guide for AI tools (like Gemini, Cursor, etc.) on the project's architecture, code style, and best practices. Adhering to these rules will ensure that generated code is consistent with the project's standards.

## 1. Core Architectural Principles

The project follows a clean, feature-based architecture with a strict separation of layers.

- **Feature-based Modularity**: Each distinct feature resides in its own directory under `lib/features`.
- **Layered Structure**: Within each feature, code is organized into `data`, `domain`, and `presentation` layers.
- **Dependency Rule**: Dependencies flow inwards: `Presentation -> Domain -> Data`. The UI (Presentation) knows about the business logic (Domain), but the Domain layer is independent of the UI and the data sources.
- **Dependency Injection**: We use the `yx_scope` package for DI. A central `AppScope` (`lib/features/app/di/app_scope.dart`) provides application-wide dependencies. Features create their own child scopes (e.g., `lib/features/debug/di/debug_scope.dart`) that inherit from the `AppScope`.
- **Shared UI**: A local package at `packages/uikit` contains shared UI components, themes, and widgets.
- **Immutability**: States emitted from BLoCs and entities should be immutable. Use `freezed` for generating immutable classes and the `copyWith` pattern for state updates.

## 2. Layer-by-Layer Guide

### Presentation Layer

The presentation layer is responsible for displaying the UI and handling user input. It should not contain any business logic.

- **Entry (`..._entry.dart`)**: The entry point for a feature route. It uses `@RoutePage` and is responsible for setting up the feature's DI scope and providing dependencies (like BLoCs) to the component.
- **Component (`..._component.dart`)**: A `StatefulWidget` that holds the UI logic. It interacts with a BLoC to receive state and dispatch events. It can expose a `ViewModel` interface to the Layout.
- **Layout (`..._layout.dart`)**: A "dumb" `StatelessWidget` that builds the UI based on the state provided by its parent Component/ViewModel. It should contain minimal logic.

**Implementation Details:**

- A `ViewModel` interface must be defined to serve as the contract between the `Component` and its `Layout`.
- The `ComponentState` implements the `ViewModel`.
- Use `BlocListener` inside the `listeners()` override to react to BLoC state changes.
- Access dependencies via a private getter that uses `context.read<ISomeScope>()`.

### Domain Layer

The core of the application, containing business logic and entities. It is independent of the UI and data layers.

- **BLoC (`..._bloc.dart`)**: Manages the state for a feature. It receives events, interacts with repositories to fetch or mutate data, and emits new states.
- **Entities**: Plain Dart objects representing core business concepts, typically created with `freezed`.
- **Repositories (`i_..._repository.dart`)**: Abstract the data sources. The interface is defined in the domain layer.

### Data Layer

Hhandles communication with data sources like APIs and local storage.

- **Repositories (Implementation)**: The concrete implementation of the repository interface. It resides in the `data/repositories` directory.
- **Services (`i_..._service.dart`, `..._service.dart`)**: Encapsulate logic for interacting with external sources.
- **Converters**: Convert data between different formats (e.g., DTOs to domain entities).

## 3. Code Style and Best Practices

- **Interfaces**: Use `abstract interface class` for all interfaces.
- **Async Operations**: All fallible asynchronous operations in repositories must be wrapped in `makeCall` from `lib/core/data/repositories/base_repository.dart` to ensure consistent error handling. The return type should be a `RequestOperation<T>`.
- **State Management**: Use the BLoC pattern for managing state in the presentation layer.
- **Private Members**: Use a leading underscore `_` for private properties and methods.

## 4. Contextual Files for AI Tools

When working on a task, it is crucial to provide the AI tool with the correct context. Here are the key files to include:

- **This file (`RULES.md`)**: Always include this file to provide the base rules and architecture overview.
- **Core Architecture**:
    - `lib/core/architecture/presentation/component.dart`
    - `lib/core/architecture/presentation/layout.dart`
    - `lib/core/architecture/data/repositories/base_repository.dart`
    - `lib/core/architecture/domain/entity/request_operation.dart`
- **UI Kit**:
    - `packages/uikit/pubspec.yaml`
    - `packages/uikit/lib/src/theme/app_theme.dart`
    - `packages/uikit/lib/src/widgets/**`
- **App Scope**:
    - `lib/features/app/di/app_scope.dart`
- **Feature-specific files**: When working on a specific feature, include all the files within that feature's directory (e.g., `lib/features/theme/**`).
- **`pubspec.yaml`**: To understand the project's dependencies.
