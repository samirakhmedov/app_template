# App Template

A production-ready Flutter template with a robust architecture, modular design, and a focus on developer productivity.

## Getting Started

This project is a starting point for a Flutter application. To get started, you'll need to have the Flutter SDK installed. This project uses [FVM](https://fvm.app/) to manage the Flutter version, so make sure you have it installed and configured.

1.  **Install FVM:**
    ```bash
    dart pub global activate fvm
    ```
2.  **Install the correct Flutter version:**
    ```bash
    fvm install
    ```
3.  **Run the app:**
    ```bash
    fvm flutter run
    ```

## Project Structure

The project is divided into a main application and a set of modular packages. This separation of concerns allows for better code organization, reusability, and maintainability.

### Core Architecture (`lib/core`)

The `lib/core` directory contains the foundational building blocks of the application's architecture.

*   **`architecture`**: This directory defines the core architectural components, including:
    *   **`component.dart`**: A base class for building UI components with a corresponding `ViewModel`.
    *   **`layout.dart`**: A base class for the layout of a component.
    *   **`presentation/state/restorable_value_notifier.dart`**: A `ValueNotifier` that automatically saves and restores its value, which is useful for preserving state across app restarts.
    *   **`mixin/lifecycle_observer_mixin.dart`**: A mixin that simplifies reacting to `AppLifecycleState` changes and memory-pressure notifications.
    *   **`mixin/theme_mixin.dart`**: A mixin that provides easy access to the current theme.
*   **`pragma_presets.dart`**: This file contains pragma presets for the Dart compiler, which can be used to enable or disable certain compiler warnings and errors.

### Packages (`packages/`)

The `packages/` directory contains a set of modular packages that provide specific functionality to the application. Each package has its own `pubspec.yaml` file and can be developed and tested independently.

*   **`analytics`**: Provides an interface for analytics services, with concrete implementations for GMS (Firebase) and HMS (Huawei).
*   **`api`**: Handles communication with a remote API using `dio` and `retrofit`.
*   **`database`**: Manages the local database using `drift`.
*   **`haptics`**: Provides a simple interface for haptic feedback.
*   **`location`**: Provides an interface for location services, with concrete implementations for GMS and HMS.
*   **`network`**: A low-level networking package that provides a `Dio` instance with interceptors.
*   **`push`**: Provides an interface for push notifications, with concrete implementations for GMS (FCM) and HMS.
*   **`secure_enclave`**: A plugin for accessing the Apple Secure Enclave.
*   **`storage`**: A package for simple key-value storage using `shared_preferences` and `flutter_secure_storage`.
*   **`uikit`**: A component library with a set of reusable UI widgets.

## Dependencies

The project uses a set of well-established and reliable dependencies to provide a solid foundation for development.

*   **`auto_route`**: A powerful routing library that generates all the necessary routing code for you.
*   **`bloc`**: A predictable state management library that helps to implement the BLoC design pattern.
*   **`freezed`**: A code generation library that helps to create immutable classes.
*   **`drift`**: A reactive persistence library for Flutter and Dart, built on top of `sqlite`.
*   **`dio`**: A powerful HTTP client for Dart, which supports interceptors, global configuration, FormData, request cancellation, file downloading, timeout, and more.
*   **`retrofit`**: A type-safe HTTP client for Dart and Flutter, based on `dio`.

## Scripts

The `scripts/` directory contains a set of useful scripts for automating common development tasks.

*   **`build_runner.sh`**: Runs the `build_runner` to generate code.
*   **`clean_ios.sh`**: Cleans the iOS build artifacts.
*   **`compile_icons.sh`**: Compiles the icons into a font.
*   **`format.sh`**: Formats the code using `dart format`.
*   **`intl_with_format.sh`**: Generates the localization files and formats the code.
*   **`propagate_secrets.sh`**: Propagates secrets to the native projects.
*   **`reset_goldens.sh`**: Resets the golden files for widget tests.

## Mason

The project uses [Mason](https://github.com/felangel/mason) to generate boilerplate code for features, blocs, screens, and widgets. The templates are located in the `tools/mason/` directory.

## Localization

The project is set up for localization using the `intl` package. The localization files are located in the `assets/resources/bundles/` directory, and the generated code is in `lib/generated/`.

To add a new language, create a new `.arb` file in the `assets/resources/bundles/` directory and run the `intl_with_format.sh` script.
