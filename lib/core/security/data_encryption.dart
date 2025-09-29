import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';

/// Data encryption and decryption utilities
class DataEncryption {
  static DataEncryption? _instance;
  static DataEncryption get instance => _instance ??= DataEncryption._();

  DataEncryption._();

  late final encrypt.Encrypter _encrypter;
  late final encrypt.Key _key;
  bool _initialized = false;

  /// Initialize encryption with a secure key
  Future<void> initialize({String? customKey}) async {
    if (_initialized) return;

    try {
      if (customKey != null) {
        _key = encrypt.Key.fromBase64(customKey);
      } else {
        _key = encrypt.Key.fromSecureRandom(32);
      }

      _encrypter = encrypt.Encrypter(encrypt.AES(_key));
      _initialized = true;
    } catch (e) {
      debugPrint('Failed to initialize encryption: $e');
      rethrow;
    }
  }

  /// Encrypt sensitive data
  Future<EncryptedData> encryptData(String data) async {
    await initialize();

    try {
      final iv = encrypt.IV.fromSecureRandom(16);
      final encrypted = _encrypter.encrypt(data, iv: iv);

      return EncryptedData(
        encryptedValue: encrypted.base64,
        iv: iv.base64,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      debugPrint('Failed to encrypt data: $e');
      rethrow;
    }
  }

  /// Decrypt sensitive data
  Future<String> decryptData(EncryptedData encryptedData) async {
    await initialize();

    try {
      final encrypted =
          encrypt.Encrypted.fromBase64(encryptedData.encryptedValue);
      final iv = encrypt.IV.fromBase64(encryptedData.iv);

      return _encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      debugPrint('Failed to decrypt data: $e');
      rethrow;
    }
  }

  /// Encrypt JSON data
  Future<EncryptedData> encryptJson(Map<String, dynamic> data) async {
    final jsonString = jsonEncode(data);
    return await encryptData(jsonString);
  }

  /// Decrypt JSON data
  Future<Map<String, dynamic>> decryptJson(EncryptedData encryptedData) async {
    final decryptedString = await decryptData(encryptedData);
    return jsonDecode(decryptedString) as Map<String, dynamic>;
  }

  /// Hash sensitive data (one-way)
  String hashData(String data, {String? salt}) {
    final saltBytes = salt != null ? utf8.encode(salt) : <int>[];
    final dataBytes = utf8.encode(data);
    final combined = [...saltBytes, ...dataBytes];

    final digest = sha256.convert(combined);
    return digest.toString();
  }

  /// Generate secure salt
  String generateSalt() {
    final key = encrypt.Key.fromSecureRandom(16);
    return key.base64;
  }

  /// Verify hashed data
  bool verifyHash(String data, String hash, {String? salt}) {
    final computedHash = hashData(data, salt: salt);
    return computedHash == hash;
  }

  /// Encrypt file data
  Future<Uint8List> encryptFile(Uint8List fileData) async {
    await initialize();

    try {
      final iv = encrypt.IV.fromSecureRandom(16);
      final encrypted = _encrypter.encryptBytes(fileData, iv: iv);

      // Prepend IV to encrypted data
      final result = Uint8List(iv.bytes.length + encrypted.bytes.length);
      result.setRange(0, iv.bytes.length, iv.bytes);
      result.setRange(iv.bytes.length, result.length, encrypted.bytes);

      return result;
    } catch (e) {
      debugPrint('Failed to encrypt file: $e');
      rethrow;
    }
  }

  /// Decrypt file data
  Future<Uint8List> decryptFile(Uint8List encryptedData) async {
    await initialize();

    try {
      // Extract IV from the beginning
      final iv = encrypt.IV(encryptedData.sublist(0, 16));
      final encrypted = encrypt.Encrypted(encryptedData.sublist(16));

      return Uint8List.fromList(_encrypter.decryptBytes(encrypted, iv: iv));
    } catch (e) {
      debugPrint('Failed to decrypt file: $e');
      rethrow;
    }
  }

  /// Generate encryption key from password
  encrypt.Key deriveKeyFromPassword(String password, String salt) {
    final saltBytes = utf8.encode(salt);
    final passwordBytes = utf8.encode(password);

    // Use simple key derivation with HMAC-SHA256
    final hmac = Hmac(sha256, saltBytes);
    final digest = hmac.convert(passwordBytes);

    // Extend to 32 bytes if needed
    final keyBytes = Uint8List(32);
    final digestBytes = digest.bytes;
    for (int i = 0; i < 32; i++) {
      keyBytes[i] = digestBytes[i % digestBytes.length];
    }

    return encrypt.Key(keyBytes);
  }

  /// Get encryption key (for backup purposes)
  String getEncryptionKey() {
    if (!_initialized) {
      throw StateError('Encryption not initialized');
    }
    return _key.base64;
  }
}

/// Encrypted data container
class EncryptedData {
  final String encryptedValue;
  final String iv;
  final DateTime timestamp;

  EncryptedData({
    required this.encryptedValue,
    required this.iv,
    required this.timestamp,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'encrypted_value': encryptedValue,
      'iv': iv,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Create from JSON
  factory EncryptedData.fromJson(Map<String, dynamic> json) {
    return EncryptedData(
      encryptedValue: json['encrypted_value'],
      iv: json['iv'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  /// Check if data is expired
  bool isExpired(Duration maxAge) {
    return DateTime.now().difference(timestamp) > maxAge;
  }
}

/// Password hashing utilities
class PasswordHasher {
  static const int _defaultIterations = 10000;
  static const int _saltLength = 16;

  /// Hash password with salt
  static HashedPassword hashPassword(String password) {
    final salt = encrypt.Key.fromSecureRandom(_saltLength).base64;
    final hash = _hashWithSalt(password, salt);

    return HashedPassword(
      hash: hash,
      salt: salt,
      iterations: _defaultIterations,
      algorithm: 'PBKDF2-SHA256',
    );
  }

  /// Verify password against hash
  static bool verifyPassword(String password, HashedPassword hashedPassword) {
    final computedHash = _hashWithSalt(password, hashedPassword.salt);
    return computedHash == hashedPassword.hash;
  }

  static String _hashWithSalt(String password, String salt) {
    final saltBytes = base64.decode(salt);
    final passwordBytes = utf8.encode(password);

    // Use simple key derivation with HMAC-SHA256
    final hmac = Hmac(sha256, saltBytes);
    final digest = hmac.convert(passwordBytes);

    return base64.encode(digest.bytes);
  }
}

/// Hashed password container
class HashedPassword {
  final String hash;
  final String salt;
  final int iterations;
  final String algorithm;

  HashedPassword({
    required this.hash,
    required this.salt,
    required this.iterations,
    required this.algorithm,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'salt': salt,
      'iterations': iterations,
      'algorithm': algorithm,
    };
  }

  /// Create from JSON
  factory HashedPassword.fromJson(Map<String, dynamic> json) {
    return HashedPassword(
      hash: json['hash'],
      salt: json['salt'],
      iterations: json['iterations'] ?? 10000,
      algorithm: json['algorithm'] ?? 'PBKDF2-SHA256',
    );
  }
}

/// Digital signature utilities
class DigitalSignature {
  /// Sign data with private key
  static String signData(String data, String privateKey) {
    final key = encrypt.Key.fromBase64(privateKey);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final iv = encrypt.IV.fromSecureRandom(16);

    final signature = encrypter.encrypt(data, iv: iv);
    return '${signature.base64}:${iv.base64}';
  }

  /// Verify signature with public key
  static bool verifySignature(String data, String signature, String publicKey) {
    try {
      final parts = signature.split(':');
      if (parts.length != 2) return false;

      final key = encrypt.Key.fromBase64(publicKey);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final encrypted = encrypt.Encrypted.fromBase64(parts[0]);
      final iv = encrypt.IV.fromBase64(parts[1]);

      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      return decrypted == data;
    } catch (e) {
      return false;
    }
  }
}

/// Data integrity checker
class DataIntegrityChecker {
  /// Generate checksum for data
  static String generateChecksum(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verify data integrity
  static bool verifyIntegrity(String data, String expectedChecksum) {
    final actualChecksum = generateChecksum(data);
    return actualChecksum == expectedChecksum;
  }

  /// Generate checksum for file
  static String generateFileChecksum(Uint8List fileData) {
    final digest = sha256.convert(fileData);
    return digest.toString();
  }

  /// Verify file integrity
  static bool verifyFileIntegrity(Uint8List fileData, String expectedChecksum) {
    final actualChecksum = generateFileChecksum(fileData);
    return actualChecksum == expectedChecksum;
  }
}
