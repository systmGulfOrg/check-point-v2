import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/leaves_api_service.dart';
import '../models/leave_balance_model.dart';
import '../models/leave_request_body.dart';
import '../models/leave_request_model.dart';
import '../models/leave_type_model.dart';
import '../models/official_holiday_model.dart';
import '../models/short_leave_model.dart';
import '../models/short_leave_request_body.dart';

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

  Future<ApiResult<List<OfficialHolidayModel>>> getOfficialHolidays({
    int? year,
  }) async {
    try {
      final models = await api.getOfficialHolidays(year: year);
      return ApiResult.success(models);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<LeaveRequestModel>> submitLeaveRequest(
    LeaveRequestBody body,
  ) async {
    try {
      final model = await api.submitLeaveRequest(body);
      return ApiResult.success(model);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<List<LeaveRequestModel>>> getLeaveRequests() async {
    try {
      final models = await api.getLeaveRequests();
      return ApiResult.success(models);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<LeaveRequestModel>> updateLeaveStatus(
    String id,
    String status,
  ) async {
    try {
      final model = await api.updateLeaveStatus(id, {'status': status});
      return ApiResult.success(model);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<void>> cancelLeaveRequest(String id) async {
    try {
      await api.cancelLeaveRequest(id);
      return const ApiResult.success(null);
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<List<ShortLeaveModel>>> getShortLeaves() async {
    try {
      return ApiResult.success(await api.getShortLeaves());
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<ShortLeaveModel>> submitShortLeaveRequest(
    ShortLeaveRequestBody body,
  ) async {
    try {
      return ApiResult.success(await api.submitShortLeaveRequest(body));
    } catch (e, _) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
