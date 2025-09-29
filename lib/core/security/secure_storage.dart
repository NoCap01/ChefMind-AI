import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

/// Secure storage manager for sensitive data
class SecureStorage {
  static SecureStorage? _instance;
  static SecureStorage get instance => _instance ??= SecureStorage._();

  SecureStorage._();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: 'chefmind_secure_prefs',
      preferencesKeyPrefix: 'chefmind_',
    ),
    iOptions: IOSOptions(
      groupId: 'group.com.chefmind.app',
      accountName: 'ChefMind',
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  late final encrypt.Encrypter _encrypter;
  late final encrypt.IV _iv;
  bool _initialized = false;

  /// Initialize the secure storage with encryption
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Generate or retrieve encryption key
      String? keyString = await _secureStorage.read(key: '_encryption_key');
      if (keyString == null) {
        final key = encrypt.Key.fromSecureRandom(32);
        keyString = key.base64;
        await _secureStorage.write(key: '_encryption_key', value: keyString);
      }

      final key = encrypt.Key.fromBase64(keyString);
      _encrypter = encrypt.Encrypter(encrypt.AES(key));
      _iv = encrypt.IV.fromSecureRandom(16);
      _initialized = true;
    } catch (e) {
      debugPrint('Failed to initialize secure storage: $e');
      rethrow;
    }
  }

  /// Store API key securely
  Future<void> storeApiKey(String service, String apiKey) async {
    await initialize();

    try {
      final encrypted = _encrypter.encrypt(apiKey, iv: _iv);
      await _secureStorage.write(
        key: 'api_key_$service',
        value: encrypted.base64,
      );

      // Store IV separately
      await _secureStorage.write(
        key: 'api_key_${service}_iv',
        value: _iv.base64,
      );
    } catch (e) {
      debugPrint('Failed to store API key for $service: $e');
      rethrow;
    }
  }

  /// Retrieve API key securely
  Future<String?> getApiKey(String service) async {
    await initialize();

    try {
      final encryptedData = await _secureStorage.read(key: 'api_key_$service');
      final ivData = await _secureStorage.read(key: 'api_key_${service}_iv');

      if (encryptedData == null || ivData == null) {
        return null;
      }

      final encrypted = encrypt.Encrypted.fromBase64(encryptedData);
      final iv = encrypt.IV.fromBase64(ivData);

      return _encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      debugPrint('Failed to retrieve API key for $service: $e');
      return null;
    }
  }

  /// Store sensitive user data
  Future<void> storeSecureData(String key, Map<String, dynamic> data) async {
    await initialize();

    try {
      final jsonString = jsonEncode(data);
      final encrypted = _encrypter.encrypt(jsonString, iv: _iv);

      await _secureStorage.write(
        key: 'secure_data_$key',
        value: encrypted.base64,
      );

      await _secureStorage.write(
        key: 'secure_data_${key}_iv',
        value: _iv.base64,
      );
    } catch (e) {
      debugPrint('Failed to store secure data for $key: $e');
      rethrow;
    }
  }

  /// Retrieve sensitive user data
  Future<Map<String, dynamic>?> getSecureData(String key) async {
    await initialize();

    try {
      final encryptedData = await _secureStorage.read(key: 'secure_data_$key');
      final ivData = await _secureStorage.read(key: 'secure_data_${key}_iv');

      if (encryptedData == null || ivData == null) {
        return null;
      }

      final encrypted = encrypt.Encrypted.fromBase64(encryptedData);
      final iv = encrypt.IV.fromBase64(ivData);

      final decryptedString = _encrypter.decrypt(encrypted, iv: iv);
      return jsonDecode(decryptedString) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Failed to retrieve secure data for $key: $e');
      return null;
    }
  }

  /// Store authentication tokens
  Future<void> storeAuthToken(String token, {DateTime? expiresAt}) async {
    await initialize();

    final data = {
      'token': token,
      'expires_at': expiresAt?.toIso8601String(),
      'stored_at': DateTime.now().toIso8601String(),
    };

    await storeSecureData('auth_token', data);
  }

  /// Retrieve authentication token
  Future<String?> getAuthToken() async {
    final data = await getSecureData('auth_token');
    if (data == null) return null;

    // Check if token is expired
    if (data['expires_at'] != null) {
      final expiresAt = DateTime.parse(data['expires_at']);
      if (DateTime.now().isAfter(expiresAt)) {
        await removeSecureData('auth_token');
        return null;
      }
    }

    return data['token'] as String?;
  }

  /// Store biometric authentication data
  Future<void> storeBiometricData(String userId, String biometricHash) async {
    await initialize();

    final data = {
      'user_id': userId,
      'biometric_hash': biometricHash,
      'created_at': DateTime.now().toIso8601String(),
    };

    await storeSecureData('biometric_data', data);
  }

  /// Verify biometric authentication
  Future<bool> verifyBiometric(String userId, String biometricHash) async {
    final data = await getSecureData('biometric_data');
    if (data == null) return false;

    return data['user_id'] == userId && data['biometric_hash'] == biometricHash;
  }

  /// Remove specific secure data
  Future<void> removeSecureData(String key) async {
    await _secureStorage.delete(key: 'secure_data_$key');
    await _secureStorage.delete(key: 'secure_data_${key}_iv');
  }

  /// Remove API key
  Future<void> removeApiKey(String service) async {
    await _secureStorage.delete(key: 'api_key_$service');
    await _secureStorage.delete(key: 'api_key_${service}_iv');
  }

  /// Clear all secure storage
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    _initialized = false;
  }

  /// Check if secure storage is available
  Future<bool> isAvailable() async {
    try {
      await _secureStorage.containsKey(key: 'test_key');
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Generate secure hash for data integrity
  String generateHash(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verify data integrity
  bool verifyHash(String data, String expectedHash) {
    final actualHash = generateHash(data);
    return actualHash == expectedHash;
  }

  /// Generate secure random string
  String generateSecureRandom(int length) {
    final key = encrypt.Key.fromSecureRandom(length);
    return key.base64.substring(0, length);
  }
}

/// API key manager with secure storage
class ApiKeyManager {
  static const String _openaiKey = 'openai';
  static const String _huggingfaceKey = 'huggingface';
  static const String _googleKey = 'google';

  /// Store OpenAI API key
  static Future<void> storeOpenAIKey(String apiKey) async {
    await SecureStorage.instance.storeApiKey(_openaiKey, apiKey);
  }

  /// Get OpenAI API key
  static Future<String?> getOpenAIKey() async {
    return await SecureStorage.instance.getApiKey(_openaiKey);
  }

  /// Store Hugging Face API key
  static Future<void> storeHuggingFaceKey(String apiKey) async {
    await SecureStorage.instance.storeApiKey(_huggingfaceKey, apiKey);
  }

  /// Get Hugging Face API key
  static Future<String?> getHuggingFaceKey() async {
    return await SecureStorage.instance.getApiKey(_huggingfaceKey);
  }

  /// Store Google API key
  static Future<void> storeGoogleKey(String apiKey) async {
    await SecureStorage.instance.storeApiKey(_googleKey, apiKey);
  }

  /// Get Google API key
  static Future<String?> getGoogleKey() async {
    return await SecureStorage.instance.getApiKey(_googleKey);
  }

  /// Remove all API keys
  static Future<void> clearAllKeys() async {
    await SecureStorage.instance.removeApiKey(_openaiKey);
    await SecureStorage.instance.removeApiKey(_huggingfaceKey);
    await SecureStorage.instance.removeApiKey(_googleKey);
  }

  /// Check if any API key is available
  static Future<bool> hasAnyApiKey() async {
    final openai = await getOpenAIKey();
    final huggingface = await getHuggingFaceKey();
    final google = await getGoogleKey();

    return openai != null || huggingface != null || google != null;
  }

  /// Validate API key format
  static bool isValidApiKeyFormat(String apiKey, String service) {
    switch (service.toLowerCase()) {
      case 'openai':
        return apiKey.startsWith('sk-') && apiKey.length >= 20;
      case 'huggingface':
        return apiKey.startsWith('hf_') && apiKey.length >= 20;
      case 'google':
        return apiKey.length >= 20; // Basic length check
      default:
        return apiKey.isNotEmpty;
    }
  }
}
