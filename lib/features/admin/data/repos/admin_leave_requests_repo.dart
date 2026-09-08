import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';

abstract class AdminLeaveRequestsRepo {
  Future<ApiResult<List<AdminLeaveRequestModel>>> getAllLeaveRequests();
  Future<ApiResult<void>> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  );
  Future<ApiResult<void>> deleteLeaveRequest(int id);
}
