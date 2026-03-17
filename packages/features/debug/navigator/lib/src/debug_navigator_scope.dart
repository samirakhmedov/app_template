import 'package:debug_navigator/src/i_debug_navigator.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// {@template debug_navigator_scope}
/// Propagates an [IDebugNavigator] implementation via Provider.
///
/// Place this widget above any component that reads [IDebugNavigator] from
/// context. When absent, components fall back to a no-op silently.
/// {@endtemplate}
class DebugNavigatorScope extends StatelessWidget {
  /// {@macro debug_navigator_scope}
  const DebugNavigatorScope({
    required this.navigator,
    required this.child,
    super.key,
  });

  /// The [IDebugNavigator] implementation to propagate.
  final IDebugNavigator navigator;

  /// The widget subtree that can access [IDebugNavigator].
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider<IDebugNavigator>.value(value: navigator, child: child);
  }
}
