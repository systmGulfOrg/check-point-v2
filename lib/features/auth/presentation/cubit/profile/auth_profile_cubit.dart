import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/auth/app_permissions.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'auth_profile_state.dart';
export 'auth_profile_state.dart';

class AuthProfileCubit extends Cubit<AuthProfileState> {
  AuthProfileCubit({required this.sessionStorage, this.attendanceRepo})
    : super(const AuthProfileState.initial());

  final AuthSessionStorage sessionStorage;
  final EmployeeAttendanceRepo? attendanceRepo;

  Future<void> loadProfile() async {
    emit(const AuthProfileState.loading());
    try {
      final userId = await sessionStorage.readUserId() ?? '';
      final username = await sessionStorage.readUserName() ?? '';
      final role = await sessionStorage.readUserRole() ?? '';
      final roles = await sessionStorage.readUserRoles();
      final effectiveRoles = roles.isNotEmpty
          ? roles
          : (role.isNotEmpty ? [role] : const <String>[]);
      final permissions = {
        ...AppPermissions.defaultsForRole(role),
        ...await sessionStorage.readPermissions(),
      }.toList();
      final name = username.trim();
      var imageUrl = await sessionStorage.readUserImageUrl();

      emit(
        AuthProfileState.success(
          name: name,
          userId: userId,
          role: role,
          username: username,
          permissions: permissions,
          roles: effectiveRoles,
          imageUrl: imageUrl,
        ),
      );

      if (attendanceRepo != null) {
        final employeeId = await sessionStorage.readEmployeeId() ?? userId;
        if (employeeId.isNotEmpty) {
          final profileResult = await attendanceRepo!.getEmployeeById(
            employeeId,
          );
          if (profileResult case Success(:final data)) {
            final remoteImageUrl = data.imageUrl;
            final remoteName = (data.name?.trim().isNotEmpty == true)
                ? data.name!.trim()
                : name;
            if (remoteImageUrl != null && remoteImageUrl.isNotEmpty) {
              await sessionStorage.saveUserImageUrl(remoteImageUrl);
              imageUrl = remoteImageUrl;
            }
            emit(
              AuthProfileState.success(
                name: remoteName,
                userId: userId,
                role: role,
                username: username,
                permissions: permissions,
                roles: effectiveRoles,
                imageUrl: imageUrl,
              ),
            );
          }
        }
      }
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
      final imageUrl = await sessionStorage.readUserImageUrl();
      emit(
        AuthProfileState.success(
          name: name,
          userId: userId,
          role: newRole,
          username: username,
          permissions: permissions,
          roles: roles,
          imageUrl: imageUrl,
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
      final imageUrl = await sessionStorage.readUserImageUrl();

      await sessionStorage.saveUserSession(
        token: token,
        userId: userId,
        departmentId: departmentId,
        branchId: branchId,
        userName: name.isNotEmpty ? name : username,
        role: role,
        roles: roles,
        imageUrl: imageUrl,
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
          imageUrl: imageUrl,
        ),
      );
    } catch (_) {
      emit(const AuthProfileState.error('errors.profileLoadFailed'));
    }
  }
}
