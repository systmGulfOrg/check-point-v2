import 'package:check_point_v2/core/core.dart';

abstract class OfflineVerificationRepo {
  Future<ApiResult<List<PendingAttendanceItem>>> getPendingVerifications({
    int page = 1,
    int limit = 50,
  });

  Future<ApiResult<void>> verifyAttendance(
    String id, {
    required String action, // 'approve' | 'reject'
    String? reason,
  });
}
