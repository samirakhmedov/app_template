import 'dart:async';

import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:flutter/widgets.dart';

/// {@template di_scope}
/// A widget that builds a subtree with dependencies from a [DependenciesRegistrar].
///
/// The [scopeBuilder] is a function that returns a [DependenciesRegistrar] for the given context.
/// The [scopeWidgetBuilder] is a function that builds a subtree with the dependencies from the [DependenciesRegistrar].
/// The [placeholder] is a widget that is shown while the dependencies are being initialized.
/// {@endtemplate}
class DiScope<D> extends StatefulWidget {
  /// {@macro di_scope}
  const DiScope({
    required this.scopeBuilder,
    required this.scopeWidgetBuilder,
    this.placeholder = const SizedBox.shrink(),
    super.key,
  });

  /// A function that returns a [DependenciesRegistrar] for the given context.
  final ScopeBuilder<D, DependenciesRegistrar<D>> scopeBuilder;

  /// A function that builds a subtree with the dependencies from the [DependenciesRegistrar].
  final ScopeWidgetBuilder<D> scopeWidgetBuilder;

  /// A widget that is shown while the dependencies are being initialized.
  final Widget placeholder;

  @override
  State<DiScope<D>> createState() => _DiScopeState<D>();
}

class _DiScopeState<D> extends State<DiScope<D>> {
  late final DependenciesRegistrar<D> scopeHolder;

  final _notifier = ValueNotifier<D?>(null);

  @override
  void initState() {
    super.initState();

    scopeHolder = widget.scopeBuilder(context);

    unawaited(_initialize());
  }

  @override
  void dispose() {
    _notifier.dispose();
    unawaited(scopeHolder.dispose());

    super.dispose();
  }

  Future<void> _initialize() async {
    final result = await scopeHolder.initialize();

    _notifier.value = result;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _notifier,
      builder: (ctx, deps, child) {
        if (deps == null) {
          return child ?? const SizedBox.shrink();
        }

        return widget.scopeWidgetBuilder(context, deps);
      },
      child: widget.placeholder,
    );
  }
}

/// A function that returns a [DependenciesRegistrar] for the given context.
typedef ScopeBuilder<D, C extends DependenciesRegistrar<D>> = C Function(BuildContext context);

/// A function that builds a subtree with the dependencies from the [DependenciesRegistrar].
typedef ScopeWidgetBuilder<D> = Widget Function(BuildContext context, D dependencies);
