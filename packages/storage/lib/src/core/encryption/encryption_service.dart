/// {@template encryption_service}
/// An interface for the encryption service.
/// {@endtemplate}
abstract interface class EncryptionService {
  /// Initializes the encryption service.
  Future<void> initialize();

  /// Encrypts a value.
  Future<String> encrypt(String value);

  /// Decrypts a value.
  Future<String> decrypt(String value);
}
