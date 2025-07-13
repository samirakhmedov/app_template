/// {@template i_debug_storage}
/// An interface for the debug storage.
/// {@endtemplate}
abstract interface class IDebugStorage {
  /// Gets the base URI.
  Future<String?> getBaseUri();

  /// Sets the base URI.
  Future<void> setBaseUri(String uri);
}
