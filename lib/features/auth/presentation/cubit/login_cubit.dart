import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/auth/auth_session_storage.dart';
import '../../../../core/auth/biometric_auth_service.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/device_identity_provider.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import '../../data/repos/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authRepo,
    required this.deviceIdentityProvider,
    required this.authSessionStorage,
    required this.biometricAuthService,
  }) : super(const LoginState.initial());

  final AuthRepo authRepo;
  final DeviceIdentityProvider deviceIdentityProvider;
  final AuthSessionStorage authSessionStorage;
  final BiometricAuthService biometricAuthService;

  Future<void> login({
    required String userName,
    required String password,
    required String role,
    required bool enableBiometricLogin,
  }) async {
    emit(const LoginState.loading());
    final request = LoginRequestModel(
      userName: userName,
      password: password,
      mobileId: deviceIdentityProvider.mobileId,
    );
    final result = await authRepo.login(request);
    switch (result) {
      case Success<LoginResponseModel>(:final data):
        final user = data;
        final hasSelectedRole =
            user.roles?.any(
              (userRole) => userRole.toLowerCase() == role.toLowerCase(),
            ) ??
            false;
        if (!hasSelectedRole) {
          emit(const LoginState.error('errors.roleMismatch'));
          return;
        }
        if (enableBiometricLogin && await biometricAuthService.isAvailable()) {
          await authSessionStorage.enableBiometricLogin(role: role);
        } else if (!enableBiometricLogin) {
          await authSessionStorage.disableBiometricLogin();
        }
        emit(LoginState.success(user));
      case Failure<LoginResponseModel>(:final failure):
        emit(LoginState.error(failure.messageKey));
    }
  }

  Future<void> loginWithBiometrics({required String localizedReason}) async {
    final session = await authSessionStorage.readBiometricSession();
    if (session == null) return;
    if (!await biometricAuthService.authenticate(
      localizedReason: localizedReason,
    )) {
      return;
    }
    emit(
      LoginState.success(
        LoginResponseModel(roles: [session.role], token: session.token),
      ),
    );
  }
}
