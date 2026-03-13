abstract interface class LoggerStrategy {
  void log(String message);

  void w(String message, [Exception? exception, StackTrace? stackTrace]);

  void exception(Object error, [StackTrace? stackTrace]);
}
