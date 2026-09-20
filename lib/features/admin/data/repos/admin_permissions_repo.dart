import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/permissions/admin_permission_employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/permissions/admin_permission_user_model.dart';
import 'package:check_point_v2/features/admin/data/models/permissions/admin_permissions_catalogue_model.dart';

abstract class AdminPermissionsRepo {
  Future<ApiResult<List<AdminPermissionEmployeeModel>>> getEmployees();

  Future<ApiResult<AdminPermissionsCatalogueModel>> getCatalogue();

  Future<ApiResult<AdminPermissionUserModel>> getUserPermissions(String userId);

  Future<ApiResult<void>> updateUserPermissions({
    required String userId,
    required List<String> permissions,
  });
}
