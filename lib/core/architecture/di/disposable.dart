/// {@template disposable}
/// A class that can be disposed.
/// {@endtemplate}
abstract interface class Disposable {
  /// {@macro disposable}
  Future<void> dispose();
}

/// {@template lifecycle_object}
/// A class that can be initialized and disposed.
/// {@endtemplate}
abstract interface class LifecycleObject extends Disposable {
  /// {@macro lifecycle_object}
  Future<void> initialize();
}
