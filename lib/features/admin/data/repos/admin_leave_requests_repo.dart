import '../../../../core/network/api_result.dart';
import '../models/admin_leave_request_model.dart';

abstract class AdminLeaveRequestsRepo {
  Future<ApiResult<List<AdminLeaveRequestModel>>> getAllLeaveRequests();
  Future<ApiResult<void>> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  );
  Future<ApiResult<void>> deleteLeaveRequest(int id);
}
