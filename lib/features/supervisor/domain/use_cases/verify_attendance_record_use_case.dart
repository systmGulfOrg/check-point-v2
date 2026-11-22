import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/data/repos/offline_verification_repo.dart';

class VerifyAttendanceRecordUseCase {
  final OfflineVerificationRepo repo;

  VerifyAttendanceRecordUseCase({required this.repo});

  Future<ApiResult<void>> call(
    String id, {
    required String action,
    String? reason,
  }) => repo.verifyAttendance(id, action: action, reason: reason);
}
