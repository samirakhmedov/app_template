import 'package:flutter/widgets.dart';

/// {@template debug_wrapper_widget}
/// Stub wrapper widget — passes the child through unchanged.
///
/// Non-debug app targets use this in place of the real DebugWrapperWidget
/// so that long-press does nothing and no debug code is compiled in.
/// {@endtemplate}
class DebugWrapperWidget extends StatelessWidget {
  /// {@macro debug_wrapper_widget}
  const DebugWrapperWidget({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
