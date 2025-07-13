import 'package:storage/src/core/storage/storage.dart';
import 'package:storage/src/features/debug/i_debug_storage.dart';

/// {@template debug_storage}
/// A debug storage for the app.
/// {@endtemplate}
class DebugStorage implements IDebugStorage {
  final Storage _storage;

  /// {@macro debug_storage}
  const DebugStorage({required Storage storage}) : _storage = storage;

  @override
  Future<String?> getBaseUri() async {
    final result = await _storage.getString(_DebugStorageKeys.baseUri.key);

    if (result == null) {
      return null;
    }

    return result;
  }

  @override
  Future<void> setBaseUri(String uri) async {
    await _storage.setString(_DebugStorageKeys.baseUri.key, uri);
  }
}

enum _DebugStorageKeys {
  baseUri('base_uri');

  final String key;

  const _DebugStorageKeys(this.key);
}
