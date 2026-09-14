import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/employee/data/models/leave_requests/employee_leave_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/apis/supervisor_api_service.dart';
import 'supervisor_leave_requests_repo.dart';

class SupervisorLeaveRequestsRepoImpl implements SupervisorLeaveRequestsRepo {
  SupervisorLeaveRequestsRepoImpl({
    required this.api,
    required this.sessionStorage,
  });
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
  Future<ApiResult<List<AdminLeaveRequestModel>>> getLeaveRequests({
    int? departmentId,
    String? type,
  }) async {
    try {
      final deptId = await _resolveDepartmentId(departmentId);
      final response = deptId != null
          ? (type != null && type.isNotEmpty && type != 'All'
                ? await api.getLeaveRequestsByDepartmentAndType(deptId, type)
                : await api.getLeaveRequestsByDepartment(deptId))
          : await api.getLeaveRequests();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes() async {
    try {
      final response = await api.getLeaveTypes();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> createLeaveRequest(
    EmployeeLeaveRequestBody body,
  ) async {
    try {
      await api.createLeaveRequest(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  ) async {
    try {
      await api.approveOrRejectLeaveRequest(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
