import 'package:app_di/app_di.dart' as base;
import 'package:common_domain/common_domain.dart';
import 'package:device_settings_domain/device_settings_domain.dart';
import 'package:haptics_domain/haptics_domain.dart';
import 'package:theme_domain/theme_domain.dart';

/// {@template i_app_scope}
/// The root scope interface shared by all app targets.
///
/// Extends the base `IAppScope` from `app_di` (required by feature scope
/// containers) and adds the blocs needed by the app wrapper components.
/// {@endtemplate}
abstract interface class IAppScope implements base.IAppScope {
  /// The theme bloc.
  ThemeBloc get themeBloc;

  /// The snack queue bloc.
  SnackQueueBloc get snackQueueBloc;

  /// The memory bloc.
  MemoryBloc get memoryBloc;

  /// The device settings bloc.
  DeviceSettingsBloc get deviceSettingsBloc;

  /// The haptics bloc (from the child haptics scope).
  HapticsBloc get hapticsBloc;
}
