import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/supervisor/data/apis/supervisor_api_service.dart';
import 'supervisor_team_repo.dart';

class SupervisorTeamRepoImpl implements SupervisorTeamRepo {
  SupervisorTeamRepoImpl({required this.api, required this.sessionStorage});
  final SupervisorApiService api;
  final AuthSessionStorage sessionStorage;

  Future<int?> _resolveDepartmentId(int? departmentId) async {
    if (departmentId != null) return departmentId;
    final cached = await sessionStorage.readDepartmentId();
    if (cached != null) return cached;
    final userId = await sessionStorage.readUserId();
    if (userId != null && userId.isNotEmpty) {
      try {
        final empRes = await api.getEmployeeById(userId);
        final id = empRes.value?.departmentId;
        if (id != null) {
          await sessionStorage.saveDepartmentId(id);
          return id;
        }
      } catch (_) {}
    }
    return null;
  }

  @override
  Future<ApiResult<List<EmployeeModel>>> getTeamEmployees({
    int? departmentId,
  }) async {
    try {
      final deptId = await _resolveDepartmentId(departmentId);
      final response = deptId != null
          ? await api.getEmployeesInDepartment(deptId)
          : await api.getEmployees(itemCount: 100);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<EmployeeModel>>> searchEmployees(String query) async {
    try {
      final response = await api.searchEmployees(query);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<EmployeeModel>> getEmployeeProfile(String id) async {
    try {
      final response = await api.getEmployeeById(id);
      final employee = response.value;
      if (employee == null) {
        return ApiResult.failure(
          const ApiFailure(messageKey: 'errors.employeeNotFound'),
        );
      }
      if (employee.departmentId != null) {
        await sessionStorage.saveDepartmentId(employee.departmentId!);
      }
      return ApiResult.success(employee);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
