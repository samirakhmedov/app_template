import 'package:app_template/core/domain/logger/logger_strategy.dart';

/// {@template logger}
/// A logger that logs messages to multiple strategies.
/// {@endtemplate}
class Logger implements LoggerStrategy {
  /// The strategies to log to.
  final List<LoggerStrategy> strategies;

  /// {@macro logger}
  const Logger({required this.strategies});

  /// Logs a message to all strategies.
  @override
  void log(String message) {
    for (final strategy in strategies) {
      strategy.log(message);
    }
  }

  @override
  void w(String message, [Exception? exception, StackTrace? stackTrace]) {
    for (final strategy in strategies) {
      strategy.w(message, exception, stackTrace);
    }
  }

  @override
  void exception(Object error, [StackTrace? stackTrace]) {
    for (final strategy in strategies) {
      strategy.exception(error, stackTrace);
    }
  }
}
