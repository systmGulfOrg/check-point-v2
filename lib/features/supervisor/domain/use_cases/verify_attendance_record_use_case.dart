import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/supervisor/data/repos/offline_verification_repo.dart';

class VerifyAttendanceRecordUseCase {
  final OfflineVerificationRepo repo;

  VerifyAttendanceRecordUseCase(this.repo);

  Future<ApiResult<void>> call(
    int id, {
    required String action,
    String? reason,
  }) =>
      repo.verifyAttendance(id, action: action, reason: reason);
}
