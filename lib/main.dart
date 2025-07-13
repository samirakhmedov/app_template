import 'package:app_template/core/config/environment/raw_environment.dart';
import 'package:app_template/core/config/environment/registrar/base_environment_registrar.dart';
import 'package:app_template/features/app/presentation/app.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized().deferFirstFrame();

  final environmentRegistrar = BaseEnvironmentRegistrar(rawEnvironment: RawEnvironment.current());

  final environment = environmentRegistrar.build();

  runApp(App(environment: environment));
}
