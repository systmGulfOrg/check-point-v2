import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';

abstract class AdminLeaveRequestsRepo {
  Future<ApiResult<List<AdminLeaveRequestModel>>> getAllLeaveRequests();
  Future<ApiResult<void>> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  );
  Future<ApiResult<void>> deleteLeaveRequest(dynamic id);

  /// V2 endpoint — supports action-based approval/rejection with an optional
  /// rejection reason (e.g. action = 'RejectHR' | 'RejectManager').
  Future<ApiResult<void>> updateLeaveStatusV2(
    String ulid,
    String action,
    String? reason,
  );

  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes();
  Future<ApiResult<void>> addLeaveType(AddLeaveTypeRequestBody body);
  Future<ApiResult<void>> editLeaveType(int id, AddLeaveTypeRequestBody body);
  Future<ApiResult<void>> deleteLeaveType(int id);
}
