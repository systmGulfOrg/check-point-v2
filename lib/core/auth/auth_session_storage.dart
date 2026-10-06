import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:check_point_v2/core/app/app_config.dart';

class AuthSessionStorage {
  AuthSessionStorage({required this.secureStorage});

  static String get tokenKey => AppConfig.authTokenKey;
  static const refreshTokenKey = 'refresh_token';
  static const userIdKey = 'user_id';
  static const employeeIdKey = 'employee_id';
  static const departmentIdKey = 'department_id';
  static const branchIdKey = 'branch_id';
  static const userNameKey = 'user_name';
  static const userRoleKey = 'user_role';
  static const permissionsKey = 'user_permissions';
  static const biometricEnabledKey = 'biometric_login_enabled';
  static const biometricRoleKey = 'biometric_login_role';
  static const biometricTokenKey = 'biometric_login_token';
  static const biometricUsernameKey = 'biometric_username';
  static const biometricPasswordKey = 'biometric_password';
  static const accountRequestDismissedMobileIdKey =
      'account_request_dismissed_mobile_id';

  final FlutterSecureStorage secureStorage;

  static Map<String, dynamic>? decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length < 2) return null;
      final normalized = base64Url.normalize(parts[1]);
      final payloadString = utf8.decode(base64Url.decode(normalized));
      return jsonDecode(payloadString) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveUserSession({
    required String token,
    String? refreshToken,
    String? userId,
    String? employeeId,
    int? departmentId,
    int? branchId,
    String? userName,
    String? role,
    List<String> permissions = const [],
  }) async {
    await secureStorage.write(key: tokenKey, value: token);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await secureStorage.write(key: refreshTokenKey, value: refreshToken);
    }
    final payload = decodeJwtPayload(token);
    final resolvedEmployeeId = employeeId ??
        payload?['employeeId'] as String? ??
        payload?['EmployeeId'] as String?;
    if (resolvedEmployeeId != null && resolvedEmployeeId.isNotEmpty) {
      await secureStorage.write(key: employeeIdKey, value: resolvedEmployeeId);
    }
    if (userId != null && userId.isNotEmpty) {
      await secureStorage.write(key: userIdKey, value: userId);
    }
    if (departmentId != null) {
      await secureStorage.write(
        key: departmentIdKey,
        value: departmentId.toString(),
      );
    }
    if (branchId != null) {
      await secureStorage.write(key: branchIdKey, value: branchId.toString());
    }
    if (userName != null && userName.isNotEmpty) {
      await secureStorage.write(key: userNameKey, value: userName);
    }
    if (role != null && role.isNotEmpty) {
      await secureStorage.write(key: userRoleKey, value: role);
    }
    await secureStorage.write(
      key: permissionsKey,
      value: permissions.join(','),
    );
  }

  Future<void> saveRefreshToken(String token) =>
      secureStorage.write(key: refreshTokenKey, value: token);

  Future<String?> readToken() => secureStorage.read(key: tokenKey);

  Future<String?> readRefreshToken() => secureStorage.read(key: refreshTokenKey);

  Future<String?> readUserId() => secureStorage.read(key: userIdKey);

  Future<String?> readEmployeeId() async {
    final direct = await secureStorage.read(key: employeeIdKey);
    if (direct != null && direct.isNotEmpty) return direct;
    final token = await readToken();
    if (token != null) {
      final payload = decodeJwtPayload(token);
      final fromToken = payload?['employeeId'] as String? ??
          payload?['EmployeeId'] as String?;
      if (fromToken != null && fromToken.isNotEmpty) {
        await secureStorage.write(key: employeeIdKey, value: fromToken);
        return fromToken;
      }
    }
    return readUserId();
  }

  Future<int?> readDepartmentId() async {
    final raw = await secureStorage.read(key: departmentIdKey);
    if (raw == null || raw.isEmpty) return null;
    return int.tryParse(raw);
  }

  Future<int?> readBranchId() async {
    final raw = await secureStorage.read(key: branchIdKey);
    return raw == null ? null : int.tryParse(raw);
  }

  Future<void> saveBranchId(int id) =>
      secureStorage.write(key: branchIdKey, value: id.toString());

  Future<void> saveDepartmentId(int id) =>
      secureStorage.write(key: departmentIdKey, value: id.toString());

  Future<String?> readUserName() => secureStorage.read(key: userNameKey);

  Future<String?> readUserRole() => secureStorage.read(key: userRoleKey);

  Future<List<String>> readPermissions() async {
    final raw = await secureStorage.read(key: permissionsKey);
    if (raw == null || raw.isEmpty) return const [];
    return raw
        .split(',')
        .map((permission) => permission.trim())
        .where((permission) => permission.isNotEmpty)
        .toSet()
        .toList();
  }

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

  Future<String?> readAccountRequestDismissedMobileId() =>
      secureStorage.read(key: accountRequestDismissedMobileIdKey);

  Future<void> dismissAccountRequestForMobileId(String mobileId) =>
      secureStorage.write(
        key: accountRequestDismissedMobileIdKey,
        value: mobileId,
      );

  Future<void> clearAccountRequestDismissal() =>
      secureStorage.delete(key: accountRequestDismissedMobileIdKey);

  Future<void> clear() async {
    await secureStorage.delete(key: tokenKey);
    await secureStorage.delete(key: refreshTokenKey);
    await secureStorage.delete(key: userIdKey);
    await secureStorage.delete(key: departmentIdKey);
    await secureStorage.delete(key: branchIdKey);
    await secureStorage.delete(key: userNameKey);
    await secureStorage.delete(key: userRoleKey);
    await secureStorage.delete(key: permissionsKey);
  }
}
