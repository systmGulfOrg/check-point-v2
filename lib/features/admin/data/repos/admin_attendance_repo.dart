import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';

abstract class AdminAttendanceRepo {
  Future<ApiResult<List<AdminAttendanceModel>>> getAdminAttendance({
    int itemCount = 1000,
    int index = 0,
  });

  Future<ApiResult<void>> updateAttendance({
    required int id,
    String? clockInTime,
    String? clockOutTime,
    String? status,
    String? reason,
  });

  Future<ApiResult<void>> deleteAttendance(int id);
}
