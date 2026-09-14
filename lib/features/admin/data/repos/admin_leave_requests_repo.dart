import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';

abstract class AdminLeaveRequestsRepo {
  Future<ApiResult<List<AdminLeaveRequestModel>>> getAllLeaveRequests();
  Future<ApiResult<void>> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  );
  Future<ApiResult<void>> deleteLeaveRequest(int id);

  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes();
  Future<ApiResult<void>> addLeaveType(AddLeaveTypeRequestBody body);
  Future<ApiResult<void>> editLeaveType(int id, AddLeaveTypeRequestBody body);
  Future<ApiResult<void>> deleteLeaveType(int id);
}
