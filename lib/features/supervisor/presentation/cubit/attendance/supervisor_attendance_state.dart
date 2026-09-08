import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';

part 'supervisor_attendance_state.freezed.dart';

@freezed
class SupervisorAttendanceState with _$SupervisorAttendanceState {
  const factory SupervisorAttendanceState.initial() =
      SupervisorAttendanceInitial;
  const factory SupervisorAttendanceState.loading() =
      SupervisorAttendanceLoading;
  const factory SupervisorAttendanceState.success({
    required List<AdminAttendanceModel> attendance,
    @Default([]) List<AdminAttendanceModel> lateComers,
    @Default([]) List<AdminAttendanceModel> earlyLeavers,
    @Default(0) int selectedFilterIndex,
  }) = SupervisorAttendanceSuccess;
  const factory SupervisorAttendanceState.error(String messageKey) =
      SupervisorAttendanceError;
}
