import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/admin_leave_request_model.dart';
import '../../../admin/data/models/admin_task_model.dart';
import '../apis/employee_api_service.dart';
import '../models/employee_change_password_request_body.dart';
import '../models/employee_leave_request_body.dart';
import '../models/employee_remove_task_request_body.dart';
import '../models/employee_update_task_status_request_body.dart';
import 'employee_action_repo.dart';

class EmployeeActionRepoImpl implements EmployeeActionRepo {
  EmployeeActionRepoImpl({required this.api});

  final EmployeeApiService api;

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
