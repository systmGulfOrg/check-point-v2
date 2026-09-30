import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../apis/attendance_points_api_service.dart';
import '../models/attendance_point_model.dart';
import '../models/points_summary_model.dart';
import 'attendance_points_repo.dart';

class AttendancePointsRepoImpl implements AttendancePointsRepo {
  AttendancePointsRepoImpl({required this.api});
  final AttendancePointsApiService api;

  @override
  Future<ApiResult<PointsSummaryModel>> getSummary({String? employeeId}) async {
    try {
      final response = await api.getSummary(employeeId) as Map<String, dynamic>;
      return ApiResult.success(
        PointsSummaryModel.fromJson(response['value'] as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AttendancePointModel>>> getHistory({
    String? employeeId,
  }) async {
    try {
      final response =
          await api.getHistory(employeeId: employeeId) as Map<String, dynamic>;
      final value = response['value'];
      final items = value is Map<String, dynamic> ? value['items'] : null;
      return ApiResult.success(
        items is List
            ? items
                  .whereType<Map<String, dynamic>>()
                  .map(AttendancePointModel.fromJson)
                  .toList()
            : const [],
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<Map<String, dynamic>>>> getMonthlySummary({
    required int year,
    required int month,
    String? employeeId,
  }) async {
    try {
      final response =
          await api.getMonthlySummary(
                year: year,
                month: month,
                employeeId: employeeId,
              )
              as Map<String, dynamic>;
      final value = response['value'];
      return ApiResult.success(
        value is List
            ? value.whereType<Map<String, dynamic>>().toList()
            : const [],
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
