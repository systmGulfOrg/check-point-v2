import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/employee/data/apis/employee_api_service.dart';
import 'package:check_point_v2/features/employee/data/models/password/employee_change_password_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/leave_requests/employee_leave_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/tasks/employee_remove_task_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/tasks/employee_update_task_status_request_body.dart';
import 'employee_action_repo.dart';

class EmployeeActionRepoImpl implements EmployeeActionRepo {
  EmployeeActionRepoImpl({required this.api});

  final EmployeeApiService api;

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
  Future<ApiResult<List<AdminLeaveRequestModel>>> getAllLeaveRequests(
    String employeeId,
  ) async {
    try {
      final response = await api.getLeaveRequestsForEmployee(employeeId);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AdminLeaveRequestModel>>> getLeaveRequestsByType(
    String employeeId,
    String type,
  ) async {
    try {
      final response = await api.getLeaveRequestsByType(employeeId, type);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteLeaveRequest(int id) async {
    try {
      await api.deleteLeaveRequest(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AdminTaskModel>>> getEmployeeTasks(
    String employeeId,
  ) async {
    try {
      final response = await api.getEmployeeTasks(employeeId);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> updateTaskStatus(
    int taskId,
    String status,
  ) async {
    try {
      await api.updateTaskStatus(
        EmployeeUpdateTaskStatusRequestBody(id: taskId, status: status),
      );
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> removeTask(
    EmployeeRemoveTaskRequestBody body,
  ) async {
    try {
      await api.removeTask(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> logTaskTime({
    required String taskId,
    required DateTime workDate,
    required int durationMinutes,
    String? note,
  }) async {
    try {
      await api.logTaskTime(taskId, {
        'workDate': workDate.toIso8601String(),
        'durationMinutes': durationMinutes,
        'note': note,
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<int>> getProductiveMinutes({
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final response = await api.getProductiveHours(
        from: from.toIso8601String(),
        to: to.toIso8601String(),
      );
      final value = response['value'];
      final total = value is Map<String, dynamic> ? value['totalMinutes'] : 0;
      return ApiResult.success(total is num ? total.toInt() : 0);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> changePassword(
    EmployeeChangePasswordRequestBody body,
  ) async {
    try {
      await api.changePassword(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
