import 'package:app_presentation/app_presentation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:splash_di/splash_di.dart';

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
    final parent = context.read<ISplashParentScope>();

    return SplashScopeRegistrar(SplashScopeHolder(parent));
  }

  @override
  WidgetBuilder get placeholder => (context) => const AppStartupLayout();
}
