import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/device/pending_device_model.dart';

part 'employee_details_state.freezed.dart';

@freezed
abstract class EmployeeDetailsState with _$EmployeeDetailsState {
  const factory EmployeeDetailsState.initial() = EmployeeDetailsInitial;
  const factory EmployeeDetailsState.loading() = EmployeeDetailsLoading;
  const factory EmployeeDetailsState.success({
    required EmployeeModel employee,
    required List<AdminAttendanceModel> attendance,
    required DateTime selectedMonth,
    required int attendedDays,
    required int absentDays,
    required int lateDays,
    required int earlyLeaveDays,
    required String totalHours,
    @Default([]) List<PendingDeviceModel> devicesHistory,
  }) = EmployeeDetailsSuccess;
  const factory EmployeeDetailsState.error(String messageKey) =
      EmployeeDetailsError;
}
