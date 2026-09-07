import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/admin_leave_request_model.dart';

abstract class SupervisorLeaveRequestsRepo {
  Future<ApiResult<List<AdminLeaveRequestModel>>> getLeaveRequests({
    int? departmentId,
    String? type,
  });
  Future<ApiResult<void>> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  );
}
