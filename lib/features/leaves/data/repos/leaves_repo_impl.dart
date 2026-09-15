
import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/leaves_api_service.dart';
import '../models/leave_balance_model.dart';
import '../models/leave_request_body.dart';
import '../models/leave_request_model.dart';
import '../models/leave_type_model.dart';

class LeavesRepoImpl {
  LeavesRepoImpl({required this.api});
  
  final LeavesApiService api;

  Future<ApiResult<List<LeaveBalanceModel>>> getLeaveBalances() async {
    try {
      final models = await api.getLeaveBalances();
      return ApiResult.success(models);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes() async {
    try {
      final models = await api.getLeaveTypes();
      return ApiResult.success(models);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<LeaveRequestModel>> submitLeaveRequest(LeaveRequestBody body) async {
    try {
      final model = await api.submitLeaveRequest(body);
      return ApiResult.success(model);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
