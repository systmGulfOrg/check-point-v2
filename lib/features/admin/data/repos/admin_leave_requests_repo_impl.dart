import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'admin_leave_requests_repo.dart';

class AdminLeaveRequestsRepoImpl implements AdminLeaveRequestsRepo {
  AdminLeaveRequestsRepoImpl({required this.api});
  final AdminApiService api;

  @override
  Future<ApiResult<List<AdminLeaveRequestModel>>> getAllLeaveRequests() async {
    try {
      final response = await api.getAllLeaveRequests();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  ) async {
    try {
      await api.approveOrRejectLeaveRequest(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteLeaveRequest(dynamic id) async {
    try {
      await api.deleteLeaveRequest(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes() async {
    try {
      final response = await api.getLeaveTypes();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addLeaveType(AddLeaveTypeRequestBody body) async {
    try {
      await api.addLeaveType(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> editLeaveType(
    int id,
    AddLeaveTypeRequestBody body,
  ) async {
    try {
      await api.editLeaveType(id, body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteLeaveType(int id) async {
    try {
      await api.deleteLeaveType(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
