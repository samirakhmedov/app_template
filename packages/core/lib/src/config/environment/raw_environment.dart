import 'package:flutter/services.dart' as services;

class RawEnvironment {
  final String appFlavor;

  factory RawEnvironment.current() {
    return RawEnvironment(
      appFlavor: services.appFlavor ?? _EnvironmentConstants.defaultFlavor,
    );
  }

  const RawEnvironment({required this.appFlavor});
}

abstract class _EnvironmentConstants {
  static const defaultFlavor = 'prod';
}
