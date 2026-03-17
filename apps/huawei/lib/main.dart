import 'package:app_target/app_target.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized().deferFirstFrame();

  final environment = BaseEnvironmentRegistrar(rawEnvironment: RawEnvironment.current()).build();

  runApp(App(environment: environment));
}
