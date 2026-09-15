import 'package:check_point_v2/features/auth/data/models/login/login_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/auth/biometric_auth_service.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';
import 'package:check_point_v2/features/auth/domain/use_cases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
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
    switch (result) {
      case Success<LoginResponseModel>(:final data):
        emit(LoginState.success(data, selectedRole: role));
      case Failure<LoginResponseModel>(:final failure):
        if (failure.messageKey == 'errors.deviceLoginAccess') {
          emit(const LoginState.deviceTransferRequired());
        } else {
          emit(LoginState.error(failure.messageKey));
        }
    }
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
         emit(const LoginState.error('deviceTransferSuccess')); // we can use error state just to show a snackbar, or create a specific state
      },
      failure: (failure) {
         emit(LoginState.error(failure.messageKey));
      },
    );
  }

  Future<bool> loginWithBiometrics({required String localizedReason}) async {
    final session = await authSessionStorage.readBiometricSession();
    if (session == null) {
      emit(const LoginState.error('errors.biometricNotConfigured'));
      return false;
    }
    final authenticated = await biometricAuthService.authenticate(
      localizedReason: localizedReason,
    );
    if (!authenticated) {
      emit(const LoginState.error('errors.biometricFailed'));
      return false;
    }
    if (session.token.isNotEmpty) {
      emit(
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
