import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthSessionStorage {
  AuthSessionStorage({required this.secureStorage});

  static const tokenKey = 'auth_token';
  static const biometricEnabledKey = 'biometric_login_enabled';
  static const biometricRoleKey = 'biometric_login_role';

  final FlutterSecureStorage secureStorage;

  Future<void> enableBiometricLogin({required String role}) async {
    await secureStorage.write(key: biometricRoleKey, value: role);
    await secureStorage.write(key: biometricEnabledKey, value: 'true');
  }

  Future<({String token, String role})?> readBiometricSession() async {
    final values = await secureStorage.readAll();
    if (values[biometricEnabledKey] != 'true') return null;

    final token = values[tokenKey];
    final role = values[biometricRoleKey];
    if (token == null || token.isEmpty || role == null || role.isEmpty) {
      return null;
    }
    return (token: token, role: role);
  }

  Future<void> disableBiometricLogin() async {
    await secureStorage.delete(key: biometricEnabledKey);
    await secureStorage.delete(key: biometricRoleKey);
  }

  Future<void> clear() async {
    await secureStorage.delete(key: tokenKey);
    await disableBiometricLogin();
  }
}
