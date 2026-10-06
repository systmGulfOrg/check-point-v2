import 'dart:io';

import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/network/device_identity_provider.dart';
import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/auth/biometric_auth_service.dart';
import 'package:check_point_v2/core/services/location_service.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';

class LoginUseCase {
  LoginUseCase({
    required this.authRepo,
    required this.deviceIdentityProvider,
    required this.authSessionStorage,
    required this.biometricAuthService,
    this.tenantStorage,
    this.locationService,
  });

  final AuthRepo authRepo;
  final DeviceIdentityProvider deviceIdentityProvider;
  final AuthSessionStorage authSessionStorage;
  final BiometricAuthService biometricAuthService;
  final TenantStorage? tenantStorage;
  final LocationService? locationService;

  bool _isRoleMatch(String userRole, String selectedRole) {
    final u = userRole.trim().toLowerCase();
    final s = selectedRole.trim().toLowerCase();
    if (u == s) return true;
    if (u == 'admin' || u == 'companyadmin') return true;
    if ((u == 'employee' || u == 'contractor' || u == 'worker') &&
        (s == 'employee' || s == 'contractor' || s == 'worker')) {
      return true;
    }
    if ((u == 'admin' || u == 'hr' || u == 'companyadmin') &&
        (s == 'admin' || s == 'hr' || s == 'companyadmin')) {
      return true;
    }
    if ((u == 'supervisor' ||
            u == 'site supervisor' ||
            u == 'sitesupervisor') &&
        (s == 'supervisor' ||
            s == 'site supervisor' ||
            s == 'sitesupervisor')) {
      return true;
    }
    return false;
  }

  Future<ApiResult<LoginResponseModel>> call({
    required String userName,
    required String password,
    required String role,
    required bool enableBiometricLogin,
  }) async {
    final tenantSlug = await tenantStorage?.readTenantSlug() ??
        await tenantStorage?.readTenantCode();

    double? lat;
    double? lng;
    if (locationService != null) {
      try {
        final position = await locationService!.getCurrentPosition().timeout(
          const Duration(milliseconds: 1500),
          onTimeout: () => null,
        );
        if (position != null) {
          lat = position.latitude;
          lng = position.longitude;
        }
      } catch (_) {
        // Location might be optional or best-effort for some roles
      }
    }

    final rawOsVersion =
        '${Platform.operatingSystem} ${Platform.operatingSystemVersion}'.trim();
    final osVersion =
        rawOsVersion.length > 48 ? rawOsVersion.substring(0, 48) : rawOsVersion;

    final request = LoginRequestModel(
      userName: userName,
      password: password,
      mobileId: deviceIdentityProvider.mobileId,
      tenantSlug: tenantSlug,
      deviceModel: Platform.isAndroid ? 'Android Device' : 'iOS Device',
      osVersion: osVersion,
      latitude: lat,
      longitude: lng,
    );

    final result = await authRepo.login(request);

    return result.when(
      success: (data) async {
        final hasSelectedRole = data.allRoles.any(
          (userRole) => _isRoleMatch(userRole, role),
        );

        if (!hasSelectedRole) {
          return const ApiResult.failure(
            ApiFailure(messageKey: 'errors.roleMismatch'),
          );
        }

        final token = data.effectiveToken ?? '';
        final refreshToken = data.effectiveRefreshToken;

        int? branchIdInt;
        final rawBranchId = data.branchId ?? data.user?.branchId;
        if (rawBranchId is int) {
          branchIdInt = rawBranchId;
        } else if (rawBranchId is String) {
          branchIdInt = int.tryParse(rawBranchId);
        }

        await authSessionStorage.saveUserSession(
          token: token,
          refreshToken: refreshToken,
          userId: data.effectiveUserId,
          employeeId: data.effectiveEmployeeId,
          userName: data.effectiveUserName,
          role: role,
          branchId: branchIdInt,
          permissions: data.allPermissions,
        );

        if (enableBiometricLogin && await biometricAuthService.isAvailable()) {
          await authSessionStorage.enableBiometricLogin(
            role: role,
            token: token,
            username: userName,
            password: password,
          );
        } else if (!enableBiometricLogin) {
          await authSessionStorage.disableBiometricLogin();
        }

        return ApiResult.success(data);
      },
      failure: ApiResult.failure,
    );
  }
}
