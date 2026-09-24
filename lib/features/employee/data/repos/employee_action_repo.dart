import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/employee/data/models/password/employee_change_password_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/leave_requests/employee_leave_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/tasks/employee_remove_task_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/tasks/employee_task_log_model.dart';

abstract class EmployeeActionRepo {
  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes();
  Future<ApiResult<void>> createLeaveRequest(EmployeeLeaveRequestBody body);
  Future<ApiResult<List<AdminLeaveRequestModel>>> getAllLeaveRequests(
    String employeeId,
  );
  Future<ApiResult<List<AdminLeaveRequestModel>>> getLeaveRequestsByType(
    String employeeId,
    String type,
  );
  Future<ApiResult<void>> deleteLeaveRequest(dynamic id);
  Future<ApiResult<List<AdminTaskModel>>> getEmployeeTasks(String employeeId);
  Future<ApiResult<List<EmployeeModel>>> getTeamEmployees(int departmentId);
  Future<ApiResult<EmployeeModel>> getEmployeeProfile(String employeeId);
  Future<ApiResult<void>> addTask(AddTaskRequestBody body);
  Future<ApiResult<void>> editTask(int id, AddTaskRequestBody body);
  Future<ApiResult<void>> assignTask(AssignTaskRequestBody body);
  Future<ApiResult<void>> updateTaskStatus(int taskId, String status);
  Future<ApiResult<void>> removeTask(EmployeeRemoveTaskRequestBody body);
  Future<ApiResult<void>> logTaskTime({
    required String taskId,
    required DateTime workDate,
    required int durationMinutes,
    String? note,
  });
  Future<ApiResult<List<EmployeeTaskLogModel>>> getTaskLogs(String taskId);
  Future<ApiResult<int>> getProductiveMinutes({
    required DateTime from,
    required DateTime to,
  });
  Future<ApiResult<void>> changePassword(
    EmployeeChangePasswordRequestBody body,
  );
}
