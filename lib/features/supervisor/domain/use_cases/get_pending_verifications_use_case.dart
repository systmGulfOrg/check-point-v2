import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/supervisor/data/repos/offline_verification_repo.dart';

class GetPendingVerificationsUseCase {
  final OfflineVerificationRepo repo;

  GetPendingVerificationsUseCase(this.repo);

  Future<ApiResult<List<PendingAttendanceItem>>> call({
    int page = 1,
    int limit = 50,
  }) =>
      repo.getPendingVerifications(page: page, limit: limit);
}
