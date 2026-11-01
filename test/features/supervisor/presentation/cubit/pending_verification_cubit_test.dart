import 'package:flutter_test/flutter_test.dart';

import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/supervisor/data/repos/offline_verification_repo.dart';
import 'package:check_point_v2/features/supervisor/domain/use_cases/get_pending_verifications_use_case.dart';
import 'package:check_point_v2/features/supervisor/domain/use_cases/verify_attendance_record_use_case.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/verification/pending_verification_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/verification/pending_verification_state.dart';

class FakeOfflineVerificationRepo implements OfflineVerificationRepo {
  final List<PendingAttendanceItem> items = [
    const PendingAttendanceItem(
      // Attendance ids are ULID strings, as the API returns them.
      id: '01M4ZNCNBVTXR7J6K27P2M0F2V',
      employeeId: 'emp-101',
      employeeName: 'Mohamed Ahmed',
      employeeCode: 'EMP101',
      verificationStatus: 'PENDING_VERIFICATION',
      verificationReasons: ['CLOCK_DRIFT'],
    ),
  ];

  String? lastAction;

  @override
  Future<ApiResult<List<PendingAttendanceItem>>> getPendingVerifications({
    int page = 1,
    int limit = 50,
  }) async {
    return ApiResult.success(items);
  }

  @override
  Future<ApiResult<void>> verifyAttendance(
    String id, {
    required String action,
    String? reason,
  }) async {
    lastAction = action;
    items.removeWhere((i) => i.id == id);
    return const ApiResult.success(null);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeOfflineVerificationRepo repo;
  late PendingVerificationCubit cubit;

  setUp(() {
    repo = FakeOfflineVerificationRepo();
    cubit = PendingVerificationCubit(
      getPendingVerificationsUseCase: GetPendingVerificationsUseCase(repo),
      verifyAttendanceRecordUseCase: VerifyAttendanceRecordUseCase(repo),
    );
  });

  tearDown(() {
    cubit.close();
  });

  test(
    'loadPendingVerifications fetches and emits loaded state with items',
    () async {
      expect(cubit.state, const PendingVerificationState.initial());

      await cubit.loadPendingVerifications();

      expect(cubit.currentItems.length, 1);
      expect(cubit.currentItems.first.id, '01M4ZNCNBVTXR7J6K27P2M0F2V');
    },
  );

  test('approve removes verified item and emits actionSuccess', () async {
    await cubit.loadPendingVerifications();
    expect(cubit.currentItems.length, 1);

    final success = await cubit.approve('01M4ZNCNBVTXR7J6K27P2M0F2V');
    expect(success, isTrue);
    // The API enum is lowercase; 'APPROVE' is rejected with a 400.
    expect(repo.lastAction, 'approve');
    expect(cubit.currentItems.isEmpty, isTrue);
  });

  test('reject removes rejected item and emits actionSuccess', () async {
    await cubit.loadPendingVerifications();
    expect(cubit.currentItems.length, 1);

    final success = await cubit.reject(
      '01M4ZNCNBVTXR7J6K27P2M0F2V',
      reason: 'Mismatch',
    );
    expect(success, isTrue);
    expect(repo.lastAction, 'reject');
    expect(cubit.currentItems.isEmpty, isTrue);
  });
}
