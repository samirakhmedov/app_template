import 'package:app_router/app_router.dart';
import 'package:debug_navigator/debug_navigator.dart';
import 'package:debug_presentation/debug_presentation.dart';
import 'package:flutter/widgets.dart';

class _AppDebugNavigator implements IDebugNavigator {
  const _AppDebugNavigator(this._router);

  final AppRouter _router;

  @override
  void openDebugScreen() => _router.pushPath(debugPath);
}

/// Wraps [child] in a [DebugNavigatorScope] wired to [router].
///
/// Pass this as `App.debugNavigatorWrapper` in `main.dart`.
Widget buildDebugNavigatorWrapper(Widget child, AppRouter router) =>
    DebugNavigatorScope(navigator: _AppDebugNavigator(router), child: child);
