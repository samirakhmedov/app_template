import 'dart:io';

abstract class TestEnvDetector {
  static bool get isTestEnvironment {
    return Platform.environment.containsKey('FLUTTER_TEST');
  }
}
