import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/core/architecture/presentation/widgets/feature_entry.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/app/presentation/app_startup_layout.dart';
import 'package:app_template/features/splash/di/i_splash_scope.dart';
import 'package:app_template/features/splash/di/splash_scope_registrar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

/// {@template splash_entry}
/// A feature entry for the splash screen.
/// {@endtemplate}
@RoutePage()
class SplashEntry extends FeatureEntry<ISplashScope> {
  /// {@macro splash_entry}
  const SplashEntry({super.key});

  @override
  List<SingleChildWidget> providers(ISplashScope scope) {
    return [BlocProvider.value(value: scope.splashBloc)];
  }

  @override
  DependenciesRegistrar<ISplashScope> scope(BuildContext context) {
    final scope = context.read<IAppScope>();

    // ignore: avoid-undisposed-instances
    return SplashScopeRegistrar(scope.splashScope);
  }

  @override
  WidgetBuilder get placeholder =>
      (context) => const AppStartupLayout();
}
