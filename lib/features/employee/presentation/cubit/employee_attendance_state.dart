import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../admin/data/models/admin_attendance_model.dart';
import '../../../admin/data/models/customer_response_model.dart';

part 'employee_attendance_state.freezed.dart';

@freezed
class EmployeeAttendanceState with _$EmployeeAttendanceState {
  const factory EmployeeAttendanceState.initial() =
      EmployeeAttendanceStateInitial;
  const factory EmployeeAttendanceState.loading() =
      EmployeeAttendanceStateLoading;
  const factory EmployeeAttendanceState.checkInSuccess(
    AdminAttendanceModel attendance,
  ) = EmployeeAttendanceStateCheckInSuccess;
  const factory EmployeeAttendanceState.checkOutSuccess(
    AdminAttendanceModel attendance,
  ) = EmployeeAttendanceStateCheckOutSuccess;
  const factory EmployeeAttendanceState.targetsLoaded(
    List<CustomerModel> targets,
  ) = EmployeeAttendanceStateTargetsLoaded;
  const factory EmployeeAttendanceState.areaValidationSuccess() =
      EmployeeAttendanceStateAreaValidationSuccess;
  const factory EmployeeAttendanceState.areaValidationError(String messageKey) =
      EmployeeAttendanceStateAreaValidationError;
  const factory EmployeeAttendanceState.historyLoaded(
    List<AdminAttendanceModel> history,
  ) = EmployeeAttendanceStateHistoryLoaded;
  const factory EmployeeAttendanceState.trackingStatusChanged(bool isEnabled) =
      EmployeeAttendanceStateTrackingStatusChanged;
  const factory EmployeeAttendanceState.actionSuccess(String message) =
      EmployeeAttendanceStateActionSuccess;
  const factory EmployeeAttendanceState.error(String messageKey) =
      EmployeeAttendanceStateError;
}
