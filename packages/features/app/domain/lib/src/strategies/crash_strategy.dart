abstract interface class CrashStrategy {
  Future<void> dispose();

  Future<void> initialize();

  void recordFatalError(Object error, [StackTrace? stackTrace]);
}
