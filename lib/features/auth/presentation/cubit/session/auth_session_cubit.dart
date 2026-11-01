import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/services/push_token_registrar.dart';
import 'package:check_point_v2/features/auth/data/repos/auth_repo.dart';
import 'auth_session_state.dart';

class AuthSessionCubit extends SafeCubit<AuthSessionState> {
  AuthSessionCubit({
    required this.authSessionStorage,
    required this.pushTokenRegistrar,
    required this.authRepo,
  }) : super(const AuthSessionState.initial());

  final AuthSessionStorage authSessionStorage;
  final PushTokenRegistrarContract pushTokenRegistrar;
  final AuthRepo authRepo;

  Future<bool> isBiometricEnabled() => authSessionStorage.isBiometricEnabled();

  Future<bool> logout() async {
    emit(const AuthSessionState.loading());
    try {
      await _clearSession();
      safeEmit(const AuthSessionState.success());
      return true;
    } catch (_) {
      safeEmit(const AuthSessionState.error('errors.logoutFailed'));
      return false;
    }
  }

  /// Deletes the signed-in account on the server (App Store 5.1.1(v)), then
  /// clears everything stored on the device for it.
  Future<void> deleteAccount(String password) async {
    emit(const AuthSessionState.loading());
    final result = await authRepo.deleteMyAccount(password);
    await result.when(
      success: (_) async {
        // The account is gone; a local cleanup failure must not keep the
        // user signed in to it.
        try {
          await _clearSession();
        } catch (_) {}
        safeEmit(const AuthSessionState.success());
      },
      failure: (failure) async =>
          safeEmit(AuthSessionState.error(failure.messageKey)),
    );
  }

  Future<void> _clearSession() async {
    try {
      await pushTokenRegistrar.stop();
    } catch (_) {}
    await authSessionStorage.disableBiometricLogin();
    await authSessionStorage.clear();
  }
}
