/// {@template i_debug_navigator}
/// An interface for navigating to the debug screen.
///
/// Implementations are provided by the app layer via a `DebugNavigatorScope`.
/// Components read this interface from context and call [openDebugScreen].
/// If no implementation is registered, the call is silently ignored.
/// {@endtemplate}
abstract interface class IDebugNavigator {
  /// Opens the debug screen.
  void openDebugScreen();
}
