import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthSessionStorage {
  AuthSessionStorage({required this.secureStorage});

  static const tokenKey = 'auth_token';
  static const userIdKey = 'user_id';
  static const departmentIdKey = 'department_id';
  static const userNameKey = 'user_name';
  static const userRoleKey = 'user_role';
  static const biometricEnabledKey = 'biometric_login_enabled';
  static const biometricRoleKey = 'biometric_login_role';
  static const biometricTokenKey = 'biometric_login_token';
  static const biometricUsernameKey = 'biometric_username';
  static const biometricPasswordKey = 'biometric_password';

  final FlutterSecureStorage secureStorage;

  Future<void> saveUserSession({
    required String token,
    String? userId,
    int? departmentId,
    String? userName,
    String? role,
  }) async {
    await secureStorage.write(key: tokenKey, value: token);
    if (userId != null && userId.isNotEmpty) {
      await secureStorage.write(key: userIdKey, value: userId);
    }
    if (departmentId != null) {
      await secureStorage.write(
        key: departmentIdKey,
        value: departmentId.toString(),
      );
    }
    if (userName != null && userName.isNotEmpty) {
      await secureStorage.write(key: userNameKey, value: userName);
    }
    if (role != null && role.isNotEmpty) {
      await secureStorage.write(key: userRoleKey, value: role);
    }
  }

  Future<String?> readToken() => secureStorage.read(key: tokenKey);

  Future<String?> readUserId() => secureStorage.read(key: userIdKey);

  Future<int?> readDepartmentId() async {
    final raw = await secureStorage.read(key: departmentIdKey);
    if (raw == null || raw.isEmpty) return null;
    return int.tryParse(raw);
  }

  Future<void> saveDepartmentId(int id) =>
      secureStorage.write(key: departmentIdKey, value: id.toString());

  Future<String?> readUserName() => secureStorage.read(key: userNameKey);

  Future<String?> readUserRole() => secureStorage.read(key: userRoleKey);

  Future<void> enableBiometricLogin({
    required String role,
    String? token,
    String? username,
    String? password,
  }) async {
    await secureStorage.write(key: biometricRoleKey, value: role);
    await secureStorage.write(key: biometricEnabledKey, value: 'true');
    if (token != null && token.isNotEmpty) {
      await secureStorage.write(key: biometricTokenKey, value: token);
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

    final token = values[biometricTokenKey] ?? values[tokenKey];
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
    await secureStorage.delete(key: biometricTokenKey);
    await secureStorage.delete(key: biometricUsernameKey);
    await secureStorage.delete(key: biometricPasswordKey);
  }

  Future<void> clear() async {
    await secureStorage.delete(key: tokenKey);
    await secureStorage.delete(key: userIdKey);
    await secureStorage.delete(key: departmentIdKey);
    await secureStorage.delete(key: userNameKey);
    await secureStorage.delete(key: userRoleKey);
  }
}
