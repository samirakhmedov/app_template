import 'package:flutter/services.dart' as services;

class RawEnvironment {
  final String appFlavor;

  final String storeType;

  factory RawEnvironment.current() {
    return RawEnvironment(
      appFlavor: services.appFlavor ?? _EnvironmentConstants.defaultFlavor,
      storeType: String.fromEnvironment(
        _EnvironmentConstants.storeTypeKey,
        defaultValue: _EnvironmentConstants.defaultStoreType,
      ),
    );
  }

  const RawEnvironment({required this.appFlavor, required this.storeType});
}

abstract class _EnvironmentConstants {
  static const storeTypeKey = 'STORE_TYPE';
  static const defaultFlavor = 'prodGms';
  static const defaultStoreType = 'legacy';
}
