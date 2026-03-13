import 'package:app_domain/app_domain.dart';

class Crashlytics implements CrashStrategy {
  final List<CrashStrategy> strategies;

  const Crashlytics({required this.strategies});

  @override
  Future<void> dispose() => Future.wait(strategies.map((strategy) => strategy.dispose()));

  @override
  void recordFatalError(Object error, [StackTrace? stackTrace]) {
    for (final strategy in strategies) {
      strategy.recordFatalError(error, stackTrace);
    }
  }

  @override
  Future<void> initialize() => Future.wait(strategies.map((strategy) => strategy.initialize()));
}
