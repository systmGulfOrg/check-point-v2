import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/admin_api_service.dart';
import '../models/police_model.dart';
import '../models/shift_model.dart';
import 'admin_shifts_policies_repo.dart';

class AdminShiftsPoliciesRepoImpl implements AdminShiftsPoliciesRepo {
  AdminShiftsPoliciesRepoImpl({required this.api});
  final AdminApiService api;

  @override
  Future<ApiResult<List<ShiftModel>>> getShifts() async {
    try {
      final response = await api.getShifts();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addShift(AddShiftRequestBody body) async {
    try {
      await api.addShift(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> editShift({
    required int id,
    required AddShiftRequestBody body,
  }) async {
    try {
      await api.editShift(id, body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteShift({required int id}) async {
    try {
      await api.deleteShift(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> assignShift(AssignShiftsRequestBody body) async {
    try {
      await api.assignShift(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<PoliceModel>>> getPoliciesByShift({
    required int shiftId,
  }) async {
    try {
      final response = await api.getPoliciesByShift(shiftId);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addPolicy(AddPoliceRequestBody body) async {
    try {
      await api.addPolicy(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> editPolicy({
    required int id,
    required AddPoliceRequestBody body,
  }) async {
    try {
      await api.editPolicy(id, body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deletePolicy({required int id}) async {
    try {
      await api.deletePolicy(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> assignPolicy(AssignPoliceRequestBody body) async {
    try {
      await api.assignPolicy(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> removeAssignPolicy(
    RemoveAssignPolicyRequestBody body,
  ) async {
    try {
      await api.removeAssignPolicy(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
