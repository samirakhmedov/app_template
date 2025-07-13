/// {@template crash_strategy}
/// A strategy for recording errors.
/// {@endtemplate}
abstract interface class CrashStrategy {
  /// Disposes the crash strategy.
  Future<void> dispose();

  /// Initializes the crash strategy.
  Future<void> initialize();

  /// Records a fatal error.
  void recordFatalError(Object error, [StackTrace? stackTrace]);
}
