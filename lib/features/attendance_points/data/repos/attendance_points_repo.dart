import 'package:check_point_v2/core/network/api_result.dart';
import '../models/attendance_point_model.dart';
import '../models/points_summary_model.dart';

abstract class AttendancePointsRepo {
  Future<ApiResult<PointsSummaryModel>> getSummary({String? employeeId});
  Future<ApiResult<List<AttendancePointModel>>> getHistory({
    String? employeeId,
  });
  Future<ApiResult<List<Map<String, dynamic>>>> getMonthlySummary({
    required int year,
    required int month,
    String? employeeId,
  });
}
