import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/src/core/storage/storage.dart';

/// {@template base_storage}
/// A base storage for the app.
/// {@endtemplate}
class BaseStorage implements Storage {
  final SharedPreferencesAsync _sharedPreferences;

  /// {@macro base_storage}
  const BaseStorage({required SharedPreferencesAsync sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<void> setString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> remove(String key) async {
    await _sharedPreferences.remove(key);
  }
}
