import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:secure_enclave/secure_enclave.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/src/core/encryption/apple_encryption_service.dart';
import 'package:storage/src/core/encryption/encryption_service.dart';
import 'package:storage/src/core/encryption/no_encryption_service.dart';
import 'package:storage/src/core/storage/base_storage.dart';
import 'package:storage/src/core/storage/secure_storage.dart';
import 'package:storage/src/core/storage/storage.dart';

/// {@template create_storage}
/// Creates a basic storage.
/// {@endtemplate}
Storage createStorage({
  required SharedPreferencesAsync sharedPreferences,
}) => BaseStorage(
  sharedPreferences: sharedPreferences,
);

/// {@template create_secure_storage}
/// Creates a secure storage.
///
/// Utilizes the encryption service for additional security.
/// {@endtemplate}
Storage createSecureStorage({
  required EncryptionService encryptionService,
  required FlutterSecureStorage flutterSecureStorage,
}) => SecureStorage(
  encryptionService: encryptionService,
  flutterSecureStorage: flutterSecureStorage,
);

/// {@template create_preferences}
/// Creates a preferences.
/// {@endtemplate}
SharedPreferencesAsync createPreferences() => SharedPreferencesAsync();

/// {@template create_encryption_service}
/// Creates an encryption service.
/// {@endtemplate}
EncryptionService createEncryptionService() {
  return switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => AppleEncryptionService(
      secureEnclave: SecureEnclave(),
    ),
    _ => NoEncryptionService(),
  };
}

/// {@template create_flutter_secure_storage}
/// Creates a flutter secure storage.
/// {@endtemplate}
FlutterSecureStorage createFlutterSecureStorage() {
  return FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.unlocked_this_device),
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
}
