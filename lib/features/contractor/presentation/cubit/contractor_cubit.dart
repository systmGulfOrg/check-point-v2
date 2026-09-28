import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/services/offline_attendance_sync_service.dart';
import 'package:check_point_v2/features/contractor/data/repos/contractor_repo.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_correction_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/offline_attendance_log_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/data/models/worker_site_assignment_model.dart';
import 'contractor_state.dart';

class ContractorCubit extends Cubit<ContractorState> {
  ContractorCubit({
    required this.contractorRepo,
    required this.offlineSyncService,
  }) : super(const ContractorState.initial());

  final ContractorRepo contractorRepo;
  final OfflineAttendanceSyncService offlineSyncService;

  List<ContractorAttendanceModel> attendanceForRange({
    DateTime? from,
    DateTime? to,
  }) {
    final attendance =
        state.mapOrNull(success: (value) => value.attendanceLogs) ??
        const <ContractorAttendanceModel>[];
    return attendance.where((item) {
      final parsed = DateTime.tryParse(item.date);
      if (parsed == null) return false;
      final day = DateTime(parsed.year, parsed.month, parsed.day);
      final start = from == null
          ? null
          : DateTime(from.year, from.month, from.day);
      final end = to == null
          ? null
          : DateTime(to.year, to.month, to.day, 23, 59, 59);
      return (start == null || !day.isBefore(start)) &&
          (end == null || !day.isAfter(end));
    }).toList();
  }

  String buildAttendanceCsv({DateTime? from, DateTime? to}) {
    final attendance = attendanceForRange(from: from, to: to);
    final rows = <List<String>>[
      [
        'Date',
        'Worker',
        'Worker Code',
        'Site',
        'Status',
        'Check In',
        'Check Out',
        'Worked Hours',
      ],
      ...attendance.map(
        (item) => [
          item.date,
          item.workerName,
          item.workerCode,
          item.siteName,
          item.status,
          item.checkInTime ?? '',
          item.checkOutTime ?? '',
          item.workedHours ?? '',
        ],
      ),
    ];
    return rows.map((row) => row.map(_escapeCsv).join(',')).join('\n');
  }

  String _escapeCsv(String value) => '"${value.replaceAll('"', '""')}"';

  Future<void> loadDashboardData({String? contractorId}) async {
    emit(const ContractorState.loading());
    final contractorsResult = await contractorRepo.getContractors();
    final customizationResult = await contractorRepo.getCustomization();
    final sitesResult = await contractorRepo.getSites();
    final assignmentsResult = await contractorRepo.getWorkerAssignments();
    final attendanceResult = await contractorRepo.getAttendance();
    final correctionsResult = await contractorRepo.getCorrections();
    final pendingPunches = await offlineSyncService.getPendingPunches();

    contractorsResult.when(
      success: (contractors) async {
        final targetContractors = contractorId == null
            ? contractors
            : contractors.where((item) => item.id == contractorId).toList();
        if (targetContractors.isEmpty) {
          emit(const ContractorState.error('errors.contractorNotFound'));
          return;
        }
        var workersFailed = false;
        final workers = <ContractorWorkerModel>[];
        for (final contractor in targetContractors) {
          final workersResult = await contractorRepo.getContractorWorkers(
            contractor.id,
          );
          workersResult.when(
            success: workers.addAll,
            failure: (failure) {
              workersFailed = true;
              emit(ContractorState.error(failure.messageKey));
            },
          );
          if (workersFailed) break;
        }
        if (workersFailed) return;

        final customization = customizationResult.when(
          success: (c) => c,
          failure: (_) => null,
        );
        final sites = sitesResult.when(
          success: (value) => value,
          failure: (_) => <SiteBoundaryModel>[],
        );
        final assignments = assignmentsResult.when(
          success: (value) => value,
          failure: (_) => <WorkerSiteAssignmentModel>[],
        );
        final attendanceLogs = attendanceResult.when(
          success: (value) => value,
          failure: (_) => <ContractorAttendanceModel>[],
        );
        final corrections = correctionsResult.when(
          success: (value) => value,
          failure: (_) => <ContractorCorrectionModel>[],
        );

        emit(
          ContractorState.success(
            contractors: contractors,
            workers: workers,
            customization: customization,
            sites: sites,
            assignments: assignments,
            attendanceLogs: attendanceLogs,
            corrections: corrections,
            pendingOfflineCount: pendingPunches.length,
          ),
        );
      },
      failure: (failure) {
        emit(ContractorState.error(failure.messageKey));
      },
    );
  }

  Future<void> punchAttendance({
    required String workerId,
    required String punchType,
    required double lat,
    required double lng,
    required String siteId,
    String? projectId,
    String? contractorId,
    String? deviceUuid,
    bool isInsideGeofence = true,
  }) async {
    final body = <String, dynamic>{
      'workerId': workerId,
      'punchType': punchType,
      'latitude': lat,
      'longitude': lng,
      'siteId': siteId,
      'projectId': ?projectId,
      'contractorId': ?contractorId,
      'deviceUuid': ?deviceUuid,
      'isInsideGeofence': isInsideGeofence,
      'timestamp': DateTime.now().toIso8601String(),
    };

    final result = punchType == 'check-in'
        ? await contractorRepo.checkIn(body)
        : await contractorRepo.checkOut(body);

    await result.when(
      success: (att) async {
        await loadDashboardData(contractorId: contractorId);
      },
      failure: (failure) async {
        if (!ApiFailureMapper.isRetryable(failure)) {
          emit(ContractorState.error(failure.messageKey));
          return;
        }

        // Only transient connectivity failures may be queued. Validation,
        // authorization, duplicate-punch, and geofence failures must remain
        // visible to the user and must never be replayed offline.
        final log = OfflineAttendanceLogModel(
          localId: DateTime.now().millisecondsSinceEpoch.toString(),
          workerId: workerId,
          punchType: punchType,
          timestamp: DateTime.now().toIso8601String(),
          latitude: lat,
          longitude: lng,
          siteId: siteId,
          projectId: projectId,
          contractorId: contractorId,
          deviceUuid: deviceUuid,
          isInsideGeofence: isInsideGeofence,
        );
        await offlineSyncService.queuePunch(log);
        await loadDashboardData(contractorId: contractorId);
      },
    );
  }

  Future<bool> submitCorrectionRequest(Map<String, dynamic> body) async {
    emit(const ContractorState.loading());
    final result = await contractorRepo.submitCorrection(body);
    return result.when(
      success: (_) async {
        await loadDashboardData();
        return true;
      },
      failure: (failure) {
        emit(ContractorState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<void> updateCorrectionStatus({
    required String correctionId,
    required String status,
    String? notes,
  }) async {
    emit(const ContractorState.loading());
    final result = await contractorRepo.updateCorrectionStatus(
      correctionId: correctionId,
      body: {'status': status, 'supervisorNotes': ?notes},
    );
    result.when(
      success: (_) => loadDashboardData(),
      failure: (failure) => emit(ContractorState.error(failure.messageKey)),
    );
  }

  Future<bool> addContractor(ContractorCompanyModel model) async {
    emit(const ContractorState.loading());
    final result = await contractorRepo.createContractor(model.toJson());
    return result.when(
      success: (_) {
        loadDashboardData();
        return true;
      },
      failure: (failure) {
        emit(ContractorState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> assignWorkerSite(Map<String, dynamic> body) async {
    emit(const ContractorState.loading());
    final result = await contractorRepo.assignWorkerToSite(body);
    return result.when(
      success: (_) {
        loadDashboardData();
        return true;
      },
      failure: (failure) {
        emit(ContractorState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> createSite(Map<String, dynamic> body) async {
    emit(const ContractorState.loading());
    final result = await contractorRepo.createSite(body);
    return result.when(
      success: (_) {
        loadDashboardData();
        return true;
      },
      failure: (failure) {
        emit(ContractorState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> addWorker({
    required String contractorId,
    required Map<String, dynamic> body,
  }) async {
    emit(const ContractorState.loading());
    final result = await contractorRepo.createContractorWorker(
      contractorId,
      body,
    );
    return result.when(
      success: (_) {
        loadDashboardData(contractorId: contractorId);
        return true;
      },
      failure: (failure) {
        emit(ContractorState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<void> syncOfflineBatch() async {
    final syncedCount = await offlineSyncService.syncPendingPunches();
    if (syncedCount > 0) {
      await loadDashboardData();
    }
  }
}
