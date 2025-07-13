import 'package:flutter/services.dart' as services;

/// {@template raw_environment}
/// The raw environment.
/// {@endtemplate}
class RawEnvironment {
  /// The app flavor.
  final String appFlavor;

  /// The store type.
  final String storeType;

  /// The current raw environment.
  factory RawEnvironment.current() {
    return RawEnvironment(
      appFlavor: services.appFlavor ?? _EnvironmentConstants.defaultFlavor,
      storeType: String.fromEnvironment(
        _EnvironmentConstants.storeTypeKey,
        defaultValue: _EnvironmentConstants.defaultStoreType,
      ),
    );
  }

  /// {@macro raw_environment}
  const RawEnvironment({required this.appFlavor, required this.storeType});
}

abstract class _EnvironmentConstants {
  static const storeTypeKey = 'STORE_TYPE';
  static const defaultFlavor = 'prodGms';
  static const defaultStoreType = 'legacy';
}
