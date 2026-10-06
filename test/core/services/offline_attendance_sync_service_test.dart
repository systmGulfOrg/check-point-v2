import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/services/offline_attendance_sync_service.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_correction_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/offline_attendance_log_model.dart';
import 'package:check_point_v2/features/contractor/data/models/samco_customization_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/data/models/worker_site_assignment_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_batch_models.dart';
import 'package:check_point_v2/features/contractor/data/repos/contractor_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeContractorRepo implements ContractorRepo {
  ApiResult<Map<String, dynamic>> syncResult = const ApiResult.success(
    <String, dynamic>{
      'results': [
        {'clientUuid': 'operation-1', 'status': 'synced'},
      ],
    },
  );
  int syncCalls = 0;

  @override
  Future<ApiResult<Map<String, dynamic>>> syncAttendanceBatch(
    List<OfflineAttendanceLogModel> logs,
  ) async {
    syncCalls++;
    return syncResult;
  }

  @override
  Future<ApiResult<List<ContractorCompanyModel>>> getContractors() async =>
      const ApiResult.success([]);

  @override
  Future<ApiResult<ContractorCompanyModel>> createContractor(
    Map<String, dynamic> body,
  ) async => throw UnimplementedError();

  @override
  Future<ApiResult<List<ContractorWorkerModel>>> getContractorWorkers(
    String contractorId,
  ) async => const ApiResult.success([]);

  @override
  Future<ApiResult<ContractorWorkerModel>> createContractorWorker(
    String contractorId,
    Map<String, dynamic> body,
  ) async => throw UnimplementedError();

  @override
  Future<ApiResult<SiteBoundaryModel>> getSiteBoundary(String siteId) async =>
      throw UnimplementedError();

  @override
  Future<ApiResult<List<WorkerSiteAssignmentModel>>> assignWorkerToSite(
    Map<String, dynamic> body,
  ) async => throw UnimplementedError();

  @override
  Future<ApiResult<List<SiteBoundaryModel>>> getSites({
    String? projectId,
    String? search,
  }) async => const ApiResult.success([]);

  @override
  Future<ApiResult<SiteBoundaryModel>> createSite(
    Map<String, dynamic> body,
  ) async => throw UnimplementedError();

  @override
  Future<ApiResult<List<WorkerSiteAssignmentModel>>> getWorkerAssignments({
    String? siteId,
    String? projectId,
    String? workerId,
    bool? isActive,
  }) async => const ApiResult.success([]);

  @override
  Future<ApiResult<List<ContractorAttendanceModel>>> getAttendance({
    int index = 0,
    int itemCount = 50,
    String? from,
    String? to,
  }) async => const ApiResult.success([]);

  @override
  Future<ApiResult<ContractorAttendanceModel>> checkIn(
    Map<String, dynamic> body,
  ) async => throw UnimplementedError();

  @override
  Future<ApiResult<ContractorAttendanceModel>> checkOut(
    Map<String, dynamic> body,
  ) async => throw UnimplementedError();

  @override
  Future<ApiResult<ContractorCorrectionModel>> submitCorrection(
    Map<String, dynamic> body,
  ) async => throw UnimplementedError();

  @override
  Future<ApiResult<List<ContractorCorrectionModel>>> getCorrections({
    String? status,
  }) async => const ApiResult.success([]);

  @override
  Future<ApiResult<ContractorCorrectionModel>> updateCorrectionStatus({
    required String correctionId,
    required Map<String, dynamic> body,
  }) async => throw UnimplementedError();

  @override
  Future<ApiResult<SamcoCustomizationModel>> getCustomization() async =>
      throw UnimplementedError();

  @override
  Future<ApiResult<SiteBoundaryModel>> getSamcoSiteBoundary(String siteId) async =>
      throw UnimplementedError();

  @override
  Future<ApiResult<void>> recordSamcoContractorAttendance(
    ContractorDailyAttendanceRequestBody body,
  ) async => const ApiResult.success(null);

  @override
  Future<ApiResult<BatchWorkerAttendanceSummaryModel>> recordSamcoBatchWorkerAttendance(
    BatchWorkerAttendanceRequestBody body,
  ) async => throw UnimplementedError();

  @override
  Future<ApiResult<List<ContractorWorkerModel>>> getSamcoWorkers({
    String? contractorId,
  }) async => const ApiResult.success([]);

  @override
  Future<ApiResult<dynamic>> syncSamcoAttendanceOffline(
    Map<String, dynamic> body,
  ) async => const ApiResult.success(null);
}

OfflineAttendanceLogModel _log(String id) => OfflineAttendanceLogModel(
  localId: id,
  workerId: 'worker-1',
  punchType: 'check-in',
  timestamp: '2026-09-28T08:00:00Z',
  latitude: 30.0,
  longitude: 31.0,
  siteId: 'site-1',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test('does not queue the same local attendance operation twice', () async {
    final service = OfflineAttendanceSyncService(
      contractorRepo: _FakeContractorRepo(),
      secureStorage: const FlutterSecureStorage(),
    );

    await service.queuePunch(_log('operation-1'));
    await service.queuePunch(_log('operation-1'));

    expect(await service.getPendingPunches(), hasLength(1));
  });

  test('clears the queue only after successful synchronization', () async {
    final repo = _FakeContractorRepo();
    final service = OfflineAttendanceSyncService(
      contractorRepo: repo,
      secureStorage: const FlutterSecureStorage(),
    );
    await service.queuePunch(_log('operation-1'));

    expect(await service.syncPendingPunches(), 1);
    expect(repo.syncCalls, 1);
    expect(await service.getPendingPunches(), isEmpty);
  });

  test('keeps the queue when synchronization fails', () async {
    final repo = _FakeContractorRepo()
      ..syncResult = const ApiResult.failure(
        ApiFailure(messageKey: 'errors.network'),
      );
    final service = OfflineAttendanceSyncService(
      contractorRepo: repo,
      secureStorage: const FlutterSecureStorage(),
    );
    await service.queuePunch(_log('operation-1'));

    expect(await service.syncPendingPunches(), 0);
    expect(await service.getPendingPunches(), hasLength(1));
  });

  test('keeps records rejected in a partially successful batch', () async {
    final repo = _FakeContractorRepo()
      ..syncResult = const ApiResult.success(<String, dynamic>{
        'results': [
          {'clientUuid': 'operation-1', 'status': 'synced'},
          {'clientUuid': 'operation-2', 'status': 'error'},
        ],
      });
    final service = OfflineAttendanceSyncService(
      contractorRepo: repo,
      secureStorage: const FlutterSecureStorage(),
    );
    await service.queuePunch(_log('operation-1'));
    await service.queuePunch(_log('operation-2'));

    expect(await service.syncPendingPunches(), 1);
    expect((await service.getPendingPunches()).single.localId, 'operation-2');
  });
}
