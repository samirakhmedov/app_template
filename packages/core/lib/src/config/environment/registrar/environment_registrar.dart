import 'package:core/src/config/environment/environment.dart';

abstract interface class EnvironmentRegistrar {
  Environment build();
}
