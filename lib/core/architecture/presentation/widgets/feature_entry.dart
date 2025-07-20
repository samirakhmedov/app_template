import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/core/architecture/di/di_scope.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template feature_entry}
/// A widget that wraps a feature entry with a [DiScope] and a [MultiProvider].
/// {@endtemplate}
abstract class FeatureEntry<S extends Scope> extends AutoRouter implements AutoRouteWrapper {
  /// {@macro feature_entry}
  const FeatureEntry({super.key});

  /// A function that returns a [DependenciesRegistrar] for the given context.
  DependenciesRegistrar<S> scope(BuildContext context);

  /// A function that returns a list of [SingleChildWidget] for the given scope.
  List<SingleChildWidget> providers(S scope);

  @override
  Widget wrappedRoute(BuildContext context) {
    return DiScope<S>(
      scopeBuilder: scope,
      scopeWidgetBuilder: (ctx, scope) {
        final providers = this.providers(scope);

        if (providers.isEmpty) {
          return this;
        }

        return MultiProvider(providers: providers, child: this);
      },
      placeholder: placeholder?.call(context) ?? const SizedBox.shrink(),
    );
  }
}
