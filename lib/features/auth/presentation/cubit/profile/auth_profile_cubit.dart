import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'auth_profile_state.dart';

class AuthProfileCubit extends Cubit<AuthProfileState> {
  AuthProfileCubit({required this.sessionStorage})
    : super(const AuthProfileState.initial());

  final AuthSessionStorage sessionStorage;

  Future<void> loadProfile() async {
    emit(const AuthProfileState.loading());
    try {
      final userId = await sessionStorage.readUserId() ?? '';
      final username = await sessionStorage.readUserName() ?? '';
      final role = await sessionStorage.readUserRole() ?? '';
      final permissions = await sessionStorage.readPermissions();
      final name = username.trim();
      emit(
        AuthProfileState.success(
          name: name,
          userId: userId,
          role: role,
          username: username,
          permissions: permissions,
        ),
      );
    } catch (_) {
      emit(const AuthProfileState.error('errors.profileLoadFailed'));
    }
  }
}
