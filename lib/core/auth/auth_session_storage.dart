import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthSessionStorage {
  AuthSessionStorage({required this.secureStorage});

  static const tokenKey = 'auth_token';
  static const biometricEnabledKey = 'biometric_login_enabled';
  static const biometricRoleKey = 'biometric_login_role';
  static const biometricUsernameKey = 'biometric_username';
  static const biometricPasswordKey = 'biometric_password';

  final FlutterSecureStorage secureStorage;

  Future<void> enableBiometricLogin({
    required String role,
    String? token,
    String? username,
    String? password,
  }) async {
    await secureStorage.write(key: biometricRoleKey, value: role);
    await secureStorage.write(key: biometricEnabledKey, value: 'true');
    if (token != null && token.isNotEmpty) {
      await secureStorage.write(key: tokenKey, value: token);
    }
    if (username != null && username.isNotEmpty) {
      await secureStorage.write(key: biometricUsernameKey, value: username);
    }
    if (password != null && password.isNotEmpty) {
      await secureStorage.write(key: biometricPasswordKey, value: password);
    }
  }

  Future<bool> isBiometricEnabled() async {
    final enabled = await secureStorage.read(key: biometricEnabledKey);
    return enabled == 'true';
  }

  Future<({String token, String role, String? username, String? password})?>
  readBiometricSession() async {
    final values = await secureStorage.readAll();
    if (values[biometricEnabledKey] != 'true') return null;

    final token = values[tokenKey];
    final role = values[biometricRoleKey];
    final username = values[biometricUsernameKey];
    final password = values[biometricPasswordKey];

    if ((token == null || token.isEmpty) &&
        (username == null || username.isEmpty)) {
      return null;
    }
    return (
      token: token ?? '',
      role: role ?? 'Employee',
      username: username,
      password: password,
    );
  }

  Future<void> disableBiometricLogin() async {
    await secureStorage.delete(key: biometricEnabledKey);
    await secureStorage.delete(key: biometricRoleKey);
    await secureStorage.delete(key: biometricUsernameKey);
    await secureStorage.delete(key: biometricPasswordKey);
  }

  Future<void> clear() async {
    await secureStorage.delete(key: tokenKey);
    await disableBiometricLogin();
  }
}
