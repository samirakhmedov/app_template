import 'dart:typed_data';

import 'package:secure_enclave/secure_enclave.dart';
import 'package:storage/src/constants.dart';
import 'package:storage/src/core/encryption/encryption_service.dart';

/// {@template apple_encryption_service}
/// An implementation of the encryption service for Apple devices.
/// {@endtemplate}
class AppleEncryptionService implements EncryptionService {
  final SecureEnclave _secureEnclave;

  /// {@macro apple_encryption_service}
  const AppleEncryptionService({required SecureEnclave secureEnclave})
    : _secureEnclave = secureEnclave;

  @override
  Future<String> encrypt(String value) async {
    final result = await _secureEnclave.encrypt(message: value, tag: kDefaultEncryptionTag);

    final res = result.value;

    return res == null ? value : String.fromCharCodes(res);
  }

  @override
  Future<String> decrypt(String value) async {
    final result = await _secureEnclave.decrypt(
      message: Uint8List.fromList(value.codeUnits),
      tag: kDefaultEncryptionTag,
    );

    final res = result.value;

    return res ?? value;
  }

  @override
  Future<void> initialize() async {
    final isKeyGenerated =
        (await _secureEnclave.isKeyCreated(tag: kDefaultEncryptionTag)).value ?? false;

    if (isKeyGenerated) {
      return;
    }

    await _secureEnclave.generateKeyPair(
      accessControl: AccessControlModel(
        tag: kDefaultEncryptionTag,
        options: [AccessControlOption.privateKeyUsage],
      ),
    );
  }
}
