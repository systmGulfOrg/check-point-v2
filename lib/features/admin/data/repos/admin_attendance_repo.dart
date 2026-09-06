import '../../../../core/network/api_result.dart';
import '../models/admin_attendance_model.dart';

abstract class AdminAttendanceRepo {
  Future<ApiResult<List<AdminAttendanceModel>>> getAdminAttendance({
    int itemCount = 1000,
    int index = 0,
  });

  Future<ApiResult<void>> deleteAttendance(int id);
}
