import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storage/src/core/encryption/encryption_service.dart';
import 'package:storage/src/core/storage/storage.dart';

/// {@template base_secure_storage}
/// A base secure storage for the app.
/// {@endtemplate}
class SecureStorage implements Storage {
  final EncryptionService _encryptionService;
  final FlutterSecureStorage _flutterSecureStorage;

  /// {@macro base_secure_storage}
  const SecureStorage({
    required EncryptionService encryptionService,
    required FlutterSecureStorage flutterSecureStorage,
  }) : _encryptionService = encryptionService,
       _flutterSecureStorage = flutterSecureStorage;

  @override
  Future<void> setString(String key, String value) async {
    final encryptedValue = await _encryptionService.encrypt(value);

    await _flutterSecureStorage.write(key: key, value: encryptedValue);
  }

  @override
  Future<String?> getString(String key) async {
    final encryptedValue = await _flutterSecureStorage.read(key: key);

    if (encryptedValue == null) {
      return null;
    }

    return _encryptionService.decrypt(encryptedValue);
  }

  @override
  Future<void> remove(String key) async {
    await _flutterSecureStorage.delete(key: key);
  }
}
