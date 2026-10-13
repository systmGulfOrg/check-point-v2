import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import '../apis/remote_work_api_service.dart';
import '../models/remote_work_policy_model.dart';
import '../models/remote_work_request_model.dart';
import 'remote_work_repo.dart';

class RemoteWorkRepoImpl implements RemoteWorkRepo {
  RemoteWorkRepoImpl({required this.api});
  final RemoteWorkApiService api;

  @override
  Future<ApiResult<List<RemoteWorkPolicyModel>>> getPolicies() async {
    try {
      final response = await api.getPolicies() as Map<String, dynamic>;
      final value = response['value'];
      final items = value is Map<String, dynamic> ? value['items'] : null;
      return ApiResult.success(
        items is List
            ? items
                  .whereType<Map<String, dynamic>>()
                  .map(RemoteWorkPolicyModel.fromJson)
                  .toList()
            : const [],
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<RemoteWorkRequestModel>>> getRequests({
    String? status,
  }) async {
    try {
      final response =
          await api.getRequests(status: status) as Map<String, dynamic>;
      final value = response['value'];
      final items = value is Map<String, dynamic> ? value['items'] : null;
      return ApiResult.success(
        items is List
            ? items
                  .whereType<Map<String, dynamic>>()
                  .map(RemoteWorkRequestModel.fromJson)
                  .toList()
            : const [],
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> createPolicy({
    required String name,
    required List<String> allowedDays,
    required String policyType,
    List<String> onsiteDays = const [],
    String? workingHoursStart,
    String? workingHoursEnd,
    int? allowedDelayTime,
    int? maxDaysPerWeek,
  }) => _run(
    () => api.createPolicy({
      'name': name,
      'policyType': policyType,
      'allowedDays': allowedDays,
      'onsiteDays': onsiteDays,
      'workingHoursStart': workingHoursStart,
      'workingHoursEnd': workingHoursEnd,
      'allowedDelayTime': allowedDelayTime,
      'requiresLocation': false,
      'maxDaysPerWeek': maxDaysPerWeek,
      'isActive': true,
    }),
  );

  @override
  Future<ApiResult<void>> deactivatePolicy(String id) =>
      _run(() => api.deactivatePolicy(id));

  @override
  Future<ApiResult<void>> updatePolicy({
    required String id,
    required String name,
    required List<String> allowedDays,
    required String policyType,
    List<String> onsiteDays = const [],
    String? workingHoursStart,
    String? workingHoursEnd,
    int? allowedDelayTime,
    int? maxDaysPerWeek,
  }) => _run(
    () => api.updatePolicy(id, {
      'name': name,
      'policyType': policyType,
      'allowedDays': allowedDays,
      'onsiteDays': onsiteDays,
      'workingHoursStart': workingHoursStart,
      'workingHoursEnd': workingHoursEnd,
      'allowedDelayTime': allowedDelayTime,
      'maxDaysPerWeek': maxDaysPerWeek,
    }),
  );

  @override
  Future<ApiResult<List<EmployeeModel>>> getPolicyEmployees(
    String policyId,
  ) async {
    try {
      final response =
          await api.getPolicyEmployees(policyId) as Map<String, dynamic>;
      final value = response['value'];
      final items = value is List
          ? value
          : (value is Map<String, dynamic> ? value['items'] : null);
      return ApiResult.success(
        items is List
            ? items
                  .whereType<Map<String, dynamic>>()
                  .map(EmployeeModel.fromJson)
                  .toList()
            : const [],
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> createRequest({
    required String requestDate,
    required String targetWorkSystem,
    String? policyId,
    String? reason,
  }) => _run(
    () => api.createRequest({
      'requestDate': requestDate,
      'targetWorkSystem': targetWorkSystem,
      'policyId': policyId,
      'reason': reason,
    }),
  );

  @override
  Future<ApiResult<void>> updateRequestStatus({
    required String id,
    required String status,
    String? reviewNote,
  }) => _run(
    () => api.updateRequestStatus(id, {
      'status': status,
      'reviewNote': reviewNote,
    }),
  );

  Future<ApiResult<void>> _run(Future<Object?> Function() action) async {
    try {
      await action();
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
