/// {@template logger_strategy}
/// A strategy for logging.
/// {@endtemplate}
abstract interface class LoggerStrategy {
  /// Logs a message.
  void log(String message);

  /// Logs a warning message.
  ///
  /// This method is used to log a warning message. The optional [exception] and [stackTrace]
  /// parameters can be used to provide additional information about the warning.
  void w(String message, [Exception? exception, StackTrace? stackTrace]);

  /// Logs an exception.
  void exception(Object error, [StackTrace? stackTrace]);
}
