/// {@template storage}
/// An interface for the storage.
/// {@endtemplate}
abstract interface class Storage {
  /// Sets a string value.
  Future<void> setString(String key, String value);

  /// Gets a string value.
  Future<String?> getString(String key);

  /// Removes a value.
  Future<void> remove(String key);
}
