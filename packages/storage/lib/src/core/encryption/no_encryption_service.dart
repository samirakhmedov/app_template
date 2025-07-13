import 'package:flutter/foundation.dart';
import 'package:storage/src/core/encryption/encryption_service.dart';

/// {@template no_encryption_service}
/// An implementation of the encryption service for no encryption.
/// {@endtemplate}
class NoEncryptionService implements EncryptionService {
  /// {@macro no_encryption_service}
  const NoEncryptionService();

  @override
  Future<String> encrypt(String value) => SynchronousFuture(value);

  @override
  Future<String> decrypt(String value) => SynchronousFuture(value);

  @override
  Future<void> initialize() => SynchronousFuture(null);
}
