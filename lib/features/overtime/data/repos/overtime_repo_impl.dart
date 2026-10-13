import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../apis/overtime_api_service.dart';
import '../models/overtime_request_model.dart';
import 'overtime_repo.dart';

class OvertimeRepoImpl implements OvertimeRepo {
  OvertimeRepoImpl({required this.api});
  final OvertimeApiService api;

  @override
  Future<ApiResult<List<OvertimeRequestModel>>> getRequests() async {
    try {
      final response = await api.getRequests() as Map<String, dynamic>;
      final value = response['value'];
      final items = value is Map<String, dynamic> ? value['items'] : value;
      return ApiResult.success(
        items is List
            ? items
                  .whereType<Map<String, dynamic>>()
                  .map(OvertimeRequestModel.fromJson)
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
    required String startTime,
    required String endTime,
    String? reason,
  }) => _run(
    () => api.createRequest({
      'requestDate': requestDate,
      'startTime': startTime,
      'endTime': endTime,
      'reason': reason,
    }),
  );

  @override
  Future<ApiResult<void>> updateStatus({
    required String id,
    required String status,
    String? reviewNote,
  }) => _run(
    () => api.updateStatus(id, {'status': status, 'reviewNote': reviewNote}),
  );

  @override
  Future<ApiResult<void>> deleteRequest({required String id}) =>
      _run(() => api.deleteRequest(id));

  Future<ApiResult<void>> _run(Future<Object?> Function() action) async {
    try {
      await action();
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
