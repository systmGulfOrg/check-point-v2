import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:check_point_v2/core/services/location_service.dart';
import 'package:check_point_v2/core/utils/app_date_formatter.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/record_worker_attendance_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_worker_attendance_repo.dart';
import 'supervisor_worker_roll_call_state.dart';

class SupervisorWorkerRollCallCubit
    extends SafeCubit<SupervisorWorkerRollCallState> {
  SupervisorWorkerRollCallCubit({
    required this.workerAttendanceRepo,
    required this.employeeAttendanceRepo,
    required this.locationService,
  }) : super(const SupervisorWorkerRollCallState.initial());

  final SupervisorWorkerAttendanceRepo workerAttendanceRepo;
  final EmployeeAttendanceRepo employeeAttendanceRepo;
  final LocationService locationService;

  List<BranchModel> _cachedSites = const [];

  Future<void> loadRollCallData({
    DateTime? date,
    String? siteId,
    String? search,
  }) async {
    final effectiveDate = date ?? DateTime.now();
    final dateStr = AppDateFormatter.formatYearMonthDay(effectiveDate);

    emit(const SupervisorWorkerRollCallState.loading());

    if (_cachedSites.isEmpty) {
      final branchesResult = await employeeAttendanceRepo.getBranches();
      branchesResult.when(
        success: (sites) => _cachedSites = sites,
        failure: (_) {},
      );
    }

    final workersResult = await workerAttendanceRepo.getWorkerAttendanceDay(
      date: dateStr,
      search: search,
    );

    workersResult.when(
      success: (workers) {
        final chosenSiteId =
            siteId ??
            (_cachedSites.isNotEmpty
                ? (_cachedSites.first.id?.toString() ?? '')
                : null);
        safeEmit(
          SupervisorWorkerRollCallState.loaded(
            workers: workers,
            sites: _cachedSites,
            selectedSiteId: chosenSiteId,
            date: effectiveDate,
          ),
        );
      },
      failure: (failure) {
        safeEmit(SupervisorWorkerRollCallState.error(failure.messageKey));
      },
    );
  }

  void selectSite(String siteId) {
    final current = state;
    if (current is SupervisorWorkerRollCallLoaded) {
      emit(current.copyWith(selectedSiteId: siteId, errorMessage: null));
    }
  }

  Future<bool> submitRollCall({
    required String siteId,
    required DateTime date,
    required List<String> workerIds,
    required String clockIn,
    String? clockOut,
    String? note,
  }) async {
    final current = state;
    if (current is! SupervisorWorkerRollCallLoaded) return false;

    emit(
      current.copyWith(isSubmitting: true, errorMessage: null, successMessage: null),
    );

    final sample = await locationService.getCurrentSample();
    final coordinates = <WorkerCoordinateModel>[];
    if (sample != null) {
      coordinates.add(
        WorkerCoordinateModel(
          latitude: sample.position.latitude,
          longitude: sample.position.longitude,
          accuracyM: sample.accuracy,
        ),
      );
    }

    final body = RecordWorkerAttendanceRequestBody(
      siteId: siteId,
      date: AppDateFormatter.formatYearMonthDay(date),
      workerIds: workerIds,
      clockIn: clockIn,
      clockOut: clockOut,
      note: note,
      coordinates: coordinates,
    );

    final result = await workerAttendanceRepo.recordWorkerAttendance(body);

    return result.when(
      success: (data) async {
        // Refresh workers for this day
        final refresh = await workerAttendanceRepo.getWorkerAttendanceDay(
          date: AppDateFormatter.formatYearMonthDay(date),
        );
        final updatedWorkers = refresh.when(
          success: (w) => w,
          failure: (_) => current.workers,
        );

        safeEmit(
          current.copyWith(
            workers: updatedWorkers,
            isSubmitting: false,
            lastResult: data,
            successMessage: 'contractorWorker.rollCall.success',
            errorMessage: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        safeEmit(
          current.copyWith(
            isSubmitting: false,
            errorMessage: failure.messageKey,
          ),
        );
        return false;
      },
    );
  }
}
