import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';


class PasswordHasher {
  static const int defaultIterations = 150000;

  static const int keyLength = 32;

  static const int saltLength = 32;

  static final Random _random = Random.secure();

  /// Hash mật khẩu theo PBKDF2-HMAC-SHA256.
  ///
  /// trả về [HashedPassword]:
  static Future<HashedPassword> hashPassword(String password) async {
    final salt = generateSalt();
    return _hashWithSalt(password, salt, defaultIterations);
  }

  static Future<HashedPassword> _hashWithSalt(
    String password,
    String salt,
    int iterations,
  ) async {
    final saltBytes = Uint8List.fromList(base64Decode(salt));
    final passwordBytes = utf8.encode(password);

    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: keyLength * 8,
    );

    final secretKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(passwordBytes),
      nonce: saltBytes,
    );

    final keyBytes = await secretKey.extractBytes();

    return HashedPassword(
      hash: base64Encode(keyBytes),
      salt: salt,
      iterations: iterations,
    );
  }

  static Future<bool> verifyPassword({
    required String password,
    required String storedHash,
    required String storedSalt,
    int iterations = defaultIterations,
  }) async {
    final computed = await _hashWithSalt(password, storedSalt, iterations);
    return computed.hash == storedHash;
  }

  static String generateSalt() {
    final bytes = Uint8List.fromList(
      List<int>.generate(saltLength, (_) => _random.nextInt(256)),
    );
    return base64Encode(bytes);
  }
}

class HashedPassword {
  final String hash;
  final String salt;
  final int iterations;

  const HashedPassword({
    required this.hash,
    required this.salt,
    required this.iterations,
  });
}