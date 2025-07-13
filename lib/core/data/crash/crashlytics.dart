import 'package:app_template/core/domain/crash/crash_strategy.dart';

/// {@template crashlytics}
/// A strategy for recording errors using multiple strategies.
/// {@endtemplate}
class Crashlytics implements CrashStrategy {
  /// The strategies to record errors with.
  final List<CrashStrategy> strategies;

  /// {@macro crashlytics}
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
