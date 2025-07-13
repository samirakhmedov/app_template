// ignore_for_file: no-empty-block

import 'package:app_template/core/architecture/presentation/component.dart';
import 'package:app_template/core/architecture/presentation/layout.dart';
import 'package:flutter/widgets.dart';

/// A mixin that simplifies reacting to [AppLifecycleState] changes and
/// memory-pressure notifications.
///
/// Usage:
/// ```dart
/// class _HomePageState extends ComponentState<HomePage, HomeViewModel, HomeLayout>
///     with LifecycleObserverMixin<HomePage, HomeViewModel, HomeLayout> {
///   @override
///   void onResumed() {
///     // App returned to foreground.
///   }
/// }
/// ```
///
/// Simply add the mixin to any `State` subclass. It will automatically add
/// itself as a [WidgetsBindingObserver] in `initState` and remove itself in
/// `dispose`. Override whichever callback(s) you need.
mixin LifecycleObserverMixin<C extends Component<V, L>, V extends ViewModel, L extends Layout<V>>
    on ComponentState<C, V, L> {
  // --------------------------- Lifecycle wiring --------------------------- //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // ------------------------- Public override hooks ------------------------ //

  /// Called whenever the app moves to the foreground and is interactive.
  ///
  /// Corresponds to [AppLifecycleState.resumed]. Override to execute logic
  /// such as refreshing data or resuming animations.
  void onResumed() {}

  /// Called when the application is inactive (e.g. an incoming phone call or
  /// system dialog is presented). Corresponds to [AppLifecycleState.inactive].
  void onInactive() {}

  /// Called when the application is not currently visible to the user, is not
  /// responding to user input, and running in the background. Corresponds to
  /// [AppLifecycleState.paused]. Ideal for saving application state.
  void onPaused() {}

  /// Called just before the application is terminated. Corresponds to
  /// [AppLifecycleState.detached]. Note that this may not always be invoked
  /// on every platform.
  void onDetached() {}

  /// Called when the framework notifies the app that the operating system is
  /// under memory pressure. Use this to release caches or other non-critical
  /// resources.
  void onMemoryPressure() {}

  // --------------------- WidgetsBindingObserver methods ------------------- //

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
      case AppLifecycleState.inactive:
        onInactive();
      case AppLifecycleState.paused:
        onPaused();
      case AppLifecycleState.detached:
        onDetached();
      case AppLifecycleState.hidden:
        // `hidden` is only available on some platforms / Flutter versions. We
        // intentionally omit it to maintain broad compatibility.
        break;
    }
  }

  @override
  void didHaveMemoryPressure() => onMemoryPressure();
}
