import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import '../../../data/models/permissions/admin_permission_employee_model.dart';
import '../../../data/models/permissions/admin_permissions_catalogue_model.dart';
import '../../../data/repos/admin_permissions_repo.dart';
import 'admin_permissions_state.dart';

class AdminPermissionsCubit extends SafeCubit<AdminPermissionsState> {
  AdminPermissionsCubit({required this.permissionsRepo})
    : super(const AdminPermissionsState.initial());

  final AdminPermissionsRepo permissionsRepo;
  List<AdminPermissionEmployeeModel> allUsers = const [];

  Future<void> load({String? selectedUserId}) async {
    emit(const AdminPermissionsState.loading());
    final usersResult = await permissionsRepo.getEmployees();
    final catalogueResult = await permissionsRepo.getCatalogue();
    usersResult.when(
      success: (users) {
        allUsers = users;
        catalogueResult.when(
          success: (catalogue) async {
            final selected = findUser(selectedUserId);
            safeEmit(
              AdminPermissionsState.success(
                users: filterUsers(''),
                catalogue: catalogue,
                searchQuery: '',
                selectedUser: selected,
                selectedPermissions:
                    selected?.user.customPermissions ?? const [],
                loadingDetails: selected != null,
                saving: false,
              ),
            );
            if (selected != null) await selectUser(selected);
          },
          failure: (failure) =>
              safeEmit(AdminPermissionsState.error(failure.messageKey)),
        );
      },
      failure: (failure) =>
          safeEmit(AdminPermissionsState.error(failure.messageKey)),
    );
  }

  void search(String query) {
    switch (state) {
      case AdminPermissionsSuccess current:
        emit(current.copyWith(searchQuery: query, users: filterUsers(query)));
      case _:
        return;
    }
  }

  Future<void> selectUser(AdminPermissionEmployeeModel user) async {
    switch (state) {
      case AdminPermissionsSuccess current:
        emit(
          current.copyWith(
            selectedUser: user,
            selectedPermissions: user.user.customPermissions,
            loadingDetails: true,
          ),
        );
      case _:
        return;
    }
    final result = await permissionsRepo.getUserPermissions(user.user.id);
    result.when(
      success: (details) {
        switch (state) {
          case AdminPermissionsSuccess current:
            safeEmit(
              current.copyWith(
                selectedPermissions: details.customPermissions,
                loadingDetails: false,
              ),
            );
          case _:
            return;
        }
      },
      failure: (_) {
        switch (state) {
          case AdminPermissionsSuccess current:
            safeEmit(current.copyWith(loadingDetails: false));
          case _:
            return;
        }
      },
    );
  }

  Future<bool> saveSelected() async {
    final current = switch (state) {
      AdminPermissionsSuccess current => current,
      _ => null,
    };
    final user = current?.selectedUser;
    if (current == null || user == null) return false;
    emit(current.copyWith(saving: true));
    final result = await permissionsRepo.updateUserPermissions(
      userId: user.user.id,
      permissions: current.selectedPermissions,
    );
    return result.when(
      success: (_) {
        switch (state) {
          case AdminPermissionsSuccess current:
            safeEmit(current.copyWith(saving: false));
          case _:
            return true;
        }
        return true;
      },
      failure: (failure) {
        safeEmit(AdminPermissionsState.error(failure.messageKey));
        return false;
      },
    );
  }

  void togglePermission(String permission) {
    final current = switch (state) {
      AdminPermissionsSuccess current => current,
      _ => null,
    };
    if (current == null || isBasePermission(permission)) return;
    final permissions = [...current.selectedPermissions];
    if (permissions.contains(permission)) {
      permissions.remove(permission);
    } else {
      permissions.add(permission);
    }
    emit(current.copyWith(selectedPermissions: permissions));
  }

  bool isBasePermission(String permission) {
    final current = switch (state) {
      AdminPermissionsSuccess current => current,
      _ => null,
    };
    final user = current?.selectedUser;
    if (current == null || user == null) return false;
    return user.user.allRoles.any(
      (role) => current.catalogue.roles[role]?.contains(permission) == true,
    );
  }

  bool isAdmin(AdminPermissionEmployeeModel user) {
    return user.user.allRoles.contains('Admin');
  }

  Map<String, List<String>> groupedPermissions(
    AdminPermissionsCatalogueModel catalogue,
  ) {
    final grouped = <String, List<String>>{};
    for (final permission in catalogue.catalogue) {
      grouped
          .putIfAbsent(permission.split('.').first, () => [])
          .add(permission);
    }
    return grouped;
  }

  AdminPermissionEmployeeModel? findUser(String? id) {
    if (id == null) return null;
    for (final user in allUsers) {
      if (user.user.id == id) return user;
    }
    return null;
  }

  List<AdminPermissionEmployeeModel> filterUsers(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return allUsers;
    return allUsers.where((user) {
      return user.name.toLowerCase().contains(normalized) ||
          user.user.allRoles.any(
            (role) => role.toLowerCase().contains(normalized),
          ) ||
          (user.email ?? '').toLowerCase().contains(normalized);
    }).toList();
  }
}
