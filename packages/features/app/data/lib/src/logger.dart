import 'package:app_domain/app_domain.dart';

class Logger implements LoggerStrategy {
  final List<LoggerStrategy> strategies;

  const Logger({required this.strategies});

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
