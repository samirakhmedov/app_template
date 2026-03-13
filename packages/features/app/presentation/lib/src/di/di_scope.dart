import 'dart:async';

import 'package:app_presentation/src/di/dependencies_registrar.dart';
import 'package:flutter/widgets.dart';

class DiScope<D> extends StatefulWidget {
  const DiScope({
    required this.scopeBuilder,
    required this.scopeWidgetBuilder,
    this.placeholder = const SizedBox.shrink(),
    super.key,
  });

  final ScopeBuilder<D, DependenciesRegistrar<D>> scopeBuilder;

  final ScopeWidgetBuilder<D> scopeWidgetBuilder;

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

typedef ScopeBuilder<D, C extends DependenciesRegistrar<D>> = C Function(BuildContext context);

typedef ScopeWidgetBuilder<D> = Widget Function(BuildContext context, D dependencies);
