import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// Utility class for hashing passwords using PBKDF2-HMAC-SHA256.
///
/// - Uses PBKDF2-HMAC-SHA256 from the `cryptography` package
/// - Default: 150,000 iterations (balance of security & performance)
/// - Generates a random salt automatically for new passwords
/// - Validates existing passwords by comparing derived keys
class PasswordHasher {
  /// Default number of PBKDF2 iterations
  /// 150,000 iterations recommended for mobile (balance of security & performance)
  static const int defaultIterations = 150000;

  /// Length of the derived key in bytes (32 bytes = 256 bits for SHA256)
  static const int keyLength = 32;

  /// Length of salt in bytes
  static const int saltLength = 32;

  /// Random generator for salt
  static final Random _random = Random.secure();

  /// Hash a password with PBKDF2-HMAC-SHA256.
  ///
  /// Returns a [HashedPassword] containing:
  /// - [hash]: the derived key as base64 string
  /// - [salt]: the generated salt as base64 string
  /// - [iterations]: number of iterations used
  static Future<HashedPassword> hashPassword(String password) async {
    final salt = generateSalt();
    return _hashWithSalt(password, salt, defaultIterations);
  }

  /// Hash a password with a specific salt and iterations.
  static Future<HashedPassword> _hashWithSalt(
    String password,
    String salt,
    int iterations,
  ) async {
    final saltBytes = Uint8List.fromList(base64Decode(salt));
    final passwordBytes = utf8.encode(password);

    // Use the same iterations as stored
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

  /// Verify a password against a stored hash.
  ///
  /// Returns `true` if the password matches, `false` otherwise.
  static Future<bool> verifyPassword({
    required String password,
    required String storedHash,
    required String storedSalt,
    int iterations = defaultIterations,
  }) async {
    final computed = await _hashWithSalt(password, storedSalt, iterations);
    return computed.hash == storedHash;
  }

  /// Generate a cryptographically secure random salt as base64.
  static String generateSalt() {
    final bytes = Uint8List.fromList(
      List<int>.generate(saltLength, (_) => _random.nextInt(256)),
    );
    return base64Encode(bytes);
  }
}

/// Result of hashing a password.
class HashedPassword {
  /// The derived key as base64 string
  final String hash;

  /// The salt as base64 string
  final String salt;

  /// Number of PBKDF2 iterations
  final int iterations;

  const HashedPassword({
    required this.hash,
    required this.salt,
    required this.iterations,
  });
}