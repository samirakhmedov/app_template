import 'package:app_template/core/config/environment/environment.dart';

/// {@template environment_registrar}
/// A registrar for the environment.
/// {@endtemplate}
abstract interface class EnvironmentRegistrar {
  /// {@macro environment_registrar}
  Environment build();
}
