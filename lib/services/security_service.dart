import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final securityServiceProvider = Provider<SecurityService>((ref) {
  return SecurityService(const FlutterSecureStorage());
});

class SecurityService {
  final FlutterSecureStorage _storage;
  static const String _pinHashKey = 'app_pin_hash';

  SecurityService(this._storage);

  /// Helper to hash a PIN with SHA-256
  String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Checks if a PIN has been set by the user
  Future<bool> isPinSet() async {
    final hash = await _storage.read(key: _pinHashKey);
    return hash != null && hash.isNotEmpty;
  }

  /// Hashes and sets the new user PIN
  Future<void> setPin(String pin) async {
    final hashed = _hashPin(pin);
    await _storage.write(key: _pinHashKey, value: hashed);
  }

  /// Verifies if the provided PIN matches the saved PIN hash
  Future<bool> verifyPin(String pin) async {
    final savedHash = await _storage.read(key: _pinHashKey);
    if (savedHash == null) return false;
    return _hashPin(pin) == savedHash;
  }

  /// Clear PIN (e.g. for reset/testing, though normally not exposed directly without verification)
  Future<void> clearPin() async {
    await _storage.delete(key: _pinHashKey);
  }
}
