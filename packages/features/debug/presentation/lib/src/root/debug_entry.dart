import 'package:app_di/app_di.dart';
import 'package:app_presentation/app_presentation.dart';
import 'package:debug_di/debug_di.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

/// {@template debug_entry}
/// A feature entry for the debug screen.
/// {@endtemplate}
class DebugEntry extends FeatureEntry<IDebugScope> {
  /// {@macro debug_entry}
  const DebugEntry({super.key});

  @override
  List<SingleChildWidget> providers(IDebugScope scope) {
    return [BlocProvider.value(value: scope.debugBloc)];
  }

  @override
  DependenciesRegistrar<IDebugScope> scope(BuildContext context) {
    final parent = context.read<IAppScope>();

    return DebugScopeRegistrar(DebugScopeHolder(parent));
  }
}
