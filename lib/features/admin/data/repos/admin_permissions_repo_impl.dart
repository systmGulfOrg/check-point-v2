import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';
import 'package:check_point_v2/features/admin/data/models/permissions/admin_permission_employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/permissions/admin_permission_user_model.dart';
import 'package:check_point_v2/features/admin/data/models/permissions/admin_permissions_catalogue_model.dart';

import 'admin_permissions_repo.dart';

class AdminPermissionsRepoImpl implements AdminPermissionsRepo {
  AdminPermissionsRepoImpl({required this.api});

  final AdminApiService api;

  @override
  Future<ApiResult<List<AdminPermissionEmployeeModel>>> getEmployees() async {
    try {
      final response = await api.getPermissionEmployees();
      final value = response['value'];
      final items = value is Map<String, dynamic> ? value['items'] : null;
      final employees = items is List
          ? items
                .whereType<Map<String, dynamic>>()
                .where((item) => item['user'] is Map<String, dynamic>)
                .map(AdminPermissionEmployeeModel.fromJson)
                .toList()
          : <AdminPermissionEmployeeModel>[];
      return ApiResult.success(employees);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminPermissionsCatalogueModel>> getCatalogue() async {
    try {
      final response = await api.getPermissionsCatalogue();
      final value = response['value'];
      if (value is! Map<String, dynamic>) {
        return const ApiResult.failure(
          ApiFailure(messageKey: 'errors.unknown'),
        );
      }
      final catalogue = (value['catalogue'] as List? ?? const [])
          .whereType<String>()
          .toList();
      final rawRoles = value['roles'] as Map? ?? const {};
      final roles = <String, List<String>>{
        for (final entry in rawRoles.entries)
          entry.key.toString(): (entry.value as List? ?? const [])
              .whereType<String>()
              .toList(),
      };
      return ApiResult.success(
        AdminPermissionsCatalogueModel(catalogue: catalogue, roles: roles),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminPermissionUserModel>> getUserPermissions(
    String userId,
  ) async {
    try {
      final response = await api.getUserPermissions(userId);
      final value = response['value'];
      if (value is! Map<String, dynamic>) {
        return const ApiResult.failure(
          ApiFailure(messageKey: 'errors.unknown'),
        );
      }
      final normalized = {
        ...value,
        'customPermissions':
            value['customGrants'] ??
            value['customPermissions'] ??
            const <String>[],
      };
      return ApiResult.success(AdminPermissionUserModel.fromJson(normalized));
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> updateUserPermissions({
    required String userId,
    required List<String> permissions,
  }) async {
    try {
      await api.updateUserPermissions(userId, {'permissions': permissions});
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
