abstract interface class Disposable {
  Future<void> dispose();
}

abstract interface class LifecycleObject extends Disposable {
  Future<void> initialize();
}
