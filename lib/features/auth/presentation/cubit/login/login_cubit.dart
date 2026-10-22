import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/auth/biometric_auth_service.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';
import 'package:check_point_v2/features/auth/domain/use_cases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends SafeCubit<LoginState> {
  LoginCubit({
    required this.loginUseCase,
    required this.authSessionStorage,
    required this.biometricAuthService,
  }) : super(const LoginState.initial());

  final LoginUseCase loginUseCase;
  final AuthSessionStorage authSessionStorage;
  final BiometricAuthService biometricAuthService;

  Future<void> login({
    required String userName,
    required String password,
    required String role,
    required bool enableBiometricLogin,
  }) async {
    emit(const LoginState.loading());
    final result = await loginUseCase(
      userName: userName,
      password: password,
      role: role,
      enableBiometricLogin: enableBiometricLogin,
    );
    await result.when(
      success: (data) async {
        await authSessionStorage.dismissAccountRequestForMobileId(
          loginUseCase.deviceIdentityProvider.mobileId,
        );
        safeEmit(LoginState.success(data, selectedRole: role));
      },
      failure: (failure) async {
        if (failure.messageKey == 'errors.deviceLoginAccess') {
          safeEmit(const LoginState.deviceTransferRequired());
        } else {
          safeEmit(LoginState.error(failure.messageKey));
        }
      },
    );
  }

  Future<void> requestDeviceTransfer({
    required String userName,
    required String password,
  }) async {
    emit(const LoginState.loading());
    final request = LoginRequestModel(
      userName: userName,
      password: password,
      mobileId: loginUseCase.deviceIdentityProvider.mobileId,
    );
    final result = await loginUseCase.authRepo.requestDeviceTransfer(request);
    result.when(
      success: (_) {
        safeEmit(const LoginState.error('deviceTransferSuccess'));
      },
      failure: (failure) {
        safeEmit(LoginState.error(failure.messageKey));
      },
    );
  }

  Future<bool> loginWithBiometrics({required String localizedReason}) async {
    final session = await authSessionStorage.readBiometricSession();
    if (session == null) {
      safeEmit(const LoginState.error('errors.biometricNotConfigured'));
      return false;
    }
    final authenticated = await biometricAuthService.authenticate(
      localizedReason: localizedReason,
    );
    if (!authenticated) {
      safeEmit(const LoginState.error('errors.biometricFailed'));
      return false;
    }
    if (session.token.isNotEmpty) {
      await authSessionStorage.dismissAccountRequestForMobileId(
        loginUseCase.deviceIdentityProvider.mobileId,
      );
      safeEmit(
        LoginState.success(
          LoginResponseModel(roles: [session.role], token: session.token),
          selectedRole: session.role,
        ),
      );
      return true;
    } else if (session.username != null && session.password != null) {
      await login(
        userName: session.username!,
        password: session.password!,
        role: session.role,
        enableBiometricLogin: true,
      );
      return true;
    }
    return false;
  }
}
