import 'package:dio/dio.dart';

import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:check_point_v2/core/network/api_constants.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'offline_verification_repo.dart';

class OfflineVerificationRepoImpl implements OfflineVerificationRepo {
  final Dio dio;

  OfflineVerificationRepoImpl({required this.dio});

  @override
  Future<ApiResult<List<PendingAttendanceItem>>> getPendingVerifications({
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.pendingAttendanceVerification,
        queryParameters: {'page': page, 'limit': limit},
      );

      final body = response.data as Map<String, dynamic>;
      final value = body['value'] as Map<String, dynamic>? ?? body;
      final items = (value['items'] as List<dynamic>?)
              ?.map((e) => PendingAttendanceItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      return ApiResult.success(items);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> verifyAttendance(
    int id, {
    required String action,
    String? reason,
  }) async {
    try {
      await dio.patch(
        ApiConstants.verifyAttendance(id),
        data: {
          'action': action,
          if (reason != null && reason.isNotEmpty) 'reason': reason,
        },
      );
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
