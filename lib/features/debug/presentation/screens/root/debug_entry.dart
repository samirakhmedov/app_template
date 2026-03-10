import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/core/architecture/presentation/widgets/feature_entry.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/debug/di/debug_scope_registrar.dart';
import 'package:app_template/features/debug/di/i_debug_scope.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

/// {@template debug_entry}
/// A feature entry for the debug screen.
/// {@endtemplate}
@RoutePage()
class DebugEntry extends FeatureEntry<IDebugScope> {
  /// {@macro debug_entry}
  const DebugEntry({super.key});

  @override
  List<SingleChildWidget> providers(IDebugScope scope) {
    return [BlocProvider.value(value: scope.debugBloc)];
  }

  @override
  DependenciesRegistrar<IDebugScope> scope(BuildContext context) {
    final scope = context.read<IAppScope>();

    return DebugScopeRegistrar(scope.debugScope);
  }
}
