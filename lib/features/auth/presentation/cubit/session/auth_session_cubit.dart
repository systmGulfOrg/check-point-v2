import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/services/push_token_registrar.dart';
import 'auth_session_state.dart';

class AuthSessionCubit extends SafeCubit<AuthSessionState> {
  AuthSessionCubit({
    required this.authSessionStorage,
    required this.pushTokenRegistrar,
  }) : super(const AuthSessionState.initial());

  final AuthSessionStorage authSessionStorage;
  final PushTokenRegistrarContract pushTokenRegistrar;

  Future<bool> isBiometricEnabled() => authSessionStorage.isBiometricEnabled();

  Future<bool> logout() async {
    emit(const AuthSessionState.loading());
    try {
      try {
        await pushTokenRegistrar.stop();
      } catch (_) {}
      await authSessionStorage.disableBiometricLogin();
      await authSessionStorage.clear();
      safeEmit(const AuthSessionState.success());
      return true;
    } catch (_) {
      safeEmit(const AuthSessionState.error('errors.logoutFailed'));
      return false;
    }
  }
}
