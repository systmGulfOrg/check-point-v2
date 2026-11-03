import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/record_worker_attendance_response_model.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/worker_day_response_model.dart';

part 'supervisor_worker_roll_call_state.freezed.dart';

@freezed
class SupervisorWorkerRollCallState with _$SupervisorWorkerRollCallState {
  const factory SupervisorWorkerRollCallState.initial() =
      SupervisorWorkerRollCallInitial;
  const factory SupervisorWorkerRollCallState.loading() =
      SupervisorWorkerRollCallLoading;
  const factory SupervisorWorkerRollCallState.loaded({
    required List<WorkerDayItemModel> workers,
    @Default([]) List<BranchModel> sites,
    String? selectedSiteId,
    required DateTime date,
    @Default(false) bool isSubmitting,
    RecordWorkerAttendanceValueModel? lastResult,
    String? successMessage,
    String? errorMessage,
  }) = SupervisorWorkerRollCallLoaded;
  const factory SupervisorWorkerRollCallState.error(String messageKey) =
      SupervisorWorkerRollCallError;
}
