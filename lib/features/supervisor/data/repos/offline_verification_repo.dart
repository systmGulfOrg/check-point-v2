import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:check_point_v2/core/network/api_result.dart';

abstract class OfflineVerificationRepo {
  Future<ApiResult<List<PendingAttendanceItem>>> getPendingVerifications({
    int page = 1,
    int limit = 50,
  });

  Future<ApiResult<void>> verifyAttendance(
    int id, {
    required String action, // 'APPROVE' | 'REJECT'
    String? reason,
  });
}
