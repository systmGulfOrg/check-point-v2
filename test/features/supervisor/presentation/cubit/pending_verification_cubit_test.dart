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
      id: 101,
      employeeId: 'emp-101',
      employeeName: 'Mohamed Ahmed',
      employeeCode: 'EMP101',
      verificationStatus: 'PENDING_VERIFICATION',
      verificationReasons: ['CLOCK_DRIFT'],
    ),
  ];

  @override
  Future<ApiResult<List<PendingAttendanceItem>>> getPendingVerifications({
    int page = 1,
    int limit = 50,
  }) async {
    return ApiResult.success(items);
  }

  @override
  Future<ApiResult<void>> verifyAttendance(
    int id, {
    required String action,
    String? reason,
  }) async {
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

  test('loadPendingVerifications fetches and emits loaded state with items', () async {
    expect(cubit.state, const PendingVerificationState.initial());

    await cubit.loadPendingVerifications();

    expect(cubit.currentItems.length, 1);
    expect(cubit.currentItems.first.id, 101);
  });

  test('approve removes verified item and emits actionSuccess', () async {
    await cubit.loadPendingVerifications();
    expect(cubit.currentItems.length, 1);

    final success = await cubit.approve(101);
    expect(success, isTrue);
    expect(cubit.currentItems.isEmpty, isTrue);
  });

  test('reject removes rejected item and emits actionSuccess', () async {
    await cubit.loadPendingVerifications();
    expect(cubit.currentItems.length, 1);

    final success = await cubit.reject(101, reason: 'Mismatch');
    expect(success, isTrue);
    expect(cubit.currentItems.isEmpty, isTrue);
  });
}
