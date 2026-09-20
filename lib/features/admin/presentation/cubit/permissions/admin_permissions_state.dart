import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/permissions/admin_permission_employee_model.dart';
import '../../../data/models/permissions/admin_permissions_catalogue_model.dart';

part 'admin_permissions_state.freezed.dart';

@freezed
class AdminPermissionsState with _$AdminPermissionsState {
  const factory AdminPermissionsState.initial() = AdminPermissionsInitial;
  const factory AdminPermissionsState.loading() = AdminPermissionsLoading;
  const factory AdminPermissionsState.success({
    required List<AdminPermissionEmployeeModel> users,
    required AdminPermissionsCatalogueModel catalogue,
    required String searchQuery,
    required AdminPermissionEmployeeModel? selectedUser,
    required List<String> selectedPermissions,
    required bool loadingDetails,
    required bool saving,
  }) = AdminPermissionsSuccess;
  const factory AdminPermissionsState.error(String messageKey) =
      AdminPermissionsError;
}
