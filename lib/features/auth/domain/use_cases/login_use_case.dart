import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/network/device_identity_provider.dart';
import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/auth/biometric_auth_service.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';

class LoginUseCase {
  LoginUseCase({
    required this.authRepo,
    required this.deviceIdentityProvider,
    required this.authSessionStorage,
    required this.biometricAuthService,
  });

  final AuthRepo authRepo;
  final DeviceIdentityProvider deviceIdentityProvider;
  final AuthSessionStorage authSessionStorage;
  final BiometricAuthService biometricAuthService;

  Future<ApiResult<LoginResponseModel>> call({
    required String userName,
    required String password,
    required String role,
    required bool enableBiometricLogin,
  }) async {
    final request = LoginRequestModel(
      userName: userName,
      password: password,
      mobileId: deviceIdentityProvider.mobileId,
    );

    final result = await authRepo.login(request);

    return result.when(
      success: (data) async {
        final hasSelectedRole = data.allRoles.any(
          (userRole) =>
              userRole.trim().toLowerCase() == role.trim().toLowerCase(),
        );

        if (!hasSelectedRole) {
          return const ApiResult.failure(
            ApiFailure(messageKey: 'errors.roleMismatch'),
          );
        }

        await authSessionStorage.saveUserSession(
          token: data.token ?? '',
          userId: data.id,
          employeeId: data.employeeId,
          userName: data.userName ?? data.name,
          role: role,
          branchId: data.branchId,
          permissions: data.permissions ?? const [],
        );

        if (enableBiometricLogin && await biometricAuthService.isAvailable()) {
          await authSessionStorage.enableBiometricLogin(
            role: role,
            token: data.token,
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
