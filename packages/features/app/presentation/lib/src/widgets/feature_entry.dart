import 'package:app_presentation/src/di/dependencies_registrar.dart';
import 'package:app_presentation/src/di/di_scope.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yx_scope/yx_scope.dart';

abstract class FeatureEntry<S extends Scope> extends AutoRouter implements AutoRouteWrapper {
  const FeatureEntry({super.key});

  DependenciesRegistrar<S> scope(BuildContext context);

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
