import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'auth_session_state.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit({required this.authSessionStorage})
    : super(const AuthSessionState.initial());

  final AuthSessionStorage authSessionStorage;

  Future<bool> logout() async {
    emit(const AuthSessionState.loading());
    try {
      await authSessionStorage.clear();
      emit(const AuthSessionState.success());
      return true;
    } catch (_) {
      emit(const AuthSessionState.error('errors.logoutFailed'));
      return false;
    }
  }
}
