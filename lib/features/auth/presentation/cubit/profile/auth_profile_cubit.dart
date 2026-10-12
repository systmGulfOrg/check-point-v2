import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/auth/app_permissions.dart';
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
      final roles = await sessionStorage.readUserRoles();
      final effectiveRoles = roles.isNotEmpty ? roles : (role.isNotEmpty ? [role] : const <String>[]);
      final permissions = {
        ...AppPermissions.defaultsForRole(role),
        ...await sessionStorage.readPermissions(),
      }.toList();
      final name = username.trim();
      emit(
        AuthProfileState.success(
          name: name,
          userId: userId,
          role: role,
          username: username,
          permissions: permissions,
          roles: effectiveRoles,
        ),
      );
    } catch (_) {
      emit(const AuthProfileState.error('errors.profileLoadFailed'));
    }
  }

  Future<void> switchRole(String newRole) async {
    try {
      await sessionStorage.saveUserRole(newRole);
      final userId = await sessionStorage.readUserId() ?? '';
      final username = await sessionStorage.readUserName() ?? '';
      final roles = await sessionStorage.readUserRoles();
      final permissions = {
        ...AppPermissions.defaultsForRole(newRole),
        ...await sessionStorage.readPermissions(),
      }.toList();
      final name = username.trim();
      emit(
        AuthProfileState.success(
          name: name,
          userId: userId,
          role: newRole,
          username: username,
          permissions: permissions,
          roles: roles,
        ),
      );
    } catch (_) {
      emit(const AuthProfileState.error('errors.profileLoadFailed'));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String username,
  }) async {
    try {
      final token = await sessionStorage.readToken() ?? '';
      final userId = await sessionStorage.readUserId() ?? '';
      final role = await sessionStorage.readUserRole() ?? '';
      final permissions = await sessionStorage.readPermissions();
      final departmentId = await sessionStorage.readDepartmentId();
      final branchId = await sessionStorage.readBranchId();

      final roles = await sessionStorage.readUserRoles();

      await sessionStorage.saveUserSession(
        token: token,
        userId: userId,
        departmentId: departmentId,
        branchId: branchId,
        userName: name.isNotEmpty ? name : username,
        role: role,
        roles: roles,
        permissions: permissions,
      );

      emit(
        AuthProfileState.success(
          name: name,
          userId: userId,
          role: role,
          username: username,
          permissions: {
            ...AppPermissions.defaultsForRole(role),
            ...permissions,
          }.toList(),
          roles: roles,
        ),
      );
    } catch (_) {
      emit(const AuthProfileState.error('errors.profileLoadFailed'));
    }
  }
}
