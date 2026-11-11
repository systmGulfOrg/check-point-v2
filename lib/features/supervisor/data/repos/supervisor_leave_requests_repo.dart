import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/employee/data/models/leave_requests/employee_leave_request_body.dart';

abstract class SupervisorLeaveRequestsRepo {
  Future<ApiResult<List<AdminLeaveRequestModel>>> getLeaveRequests({
    int? departmentId,
    String? type,
  });
  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes();
  Future<ApiResult<void>> createLeaveRequest(EmployeeLeaveRequestBody body);
  Future<ApiResult<void>> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  );
  Future<ApiResult<void>> approveOrRejectLeaveRequestV2(
    String ulid,
    String action,
    String? reason,
  );

  /// Revokes an approved leave (manager or HR; never your own).
  Future<ApiResult<void>> revokeLeaveRequest(String ulid, String reason);
}
