import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/device/pending_device_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/leaves/data/models/leave_balance_model.dart';
import 'package:check_point_v2/features/leaves/data/models/short_leave_model.dart';

part 'admin_employee_profile_state.freezed.dart';

@freezed
class AdminEmployeeProfileState with _$AdminEmployeeProfileState {
  const factory AdminEmployeeProfileState.initial() = _Initial;
  const factory AdminEmployeeProfileState.loading() = _Loading;
  const factory AdminEmployeeProfileState.success({
    required EmployeeModel employee,
    required List<AdminAttendanceModel> attendance,
    required DateTime selectedMonth,
    required int attendedDays,
    required int absentDays,
    required int lateDays,
    required int earlyLeaveDays,
    required String totalHours,
    required List<PendingDeviceModel> devicesHistory,
    required List<AdminLeaveRequestModel> leaveRequests,
    required List<LeaveBalanceModel> leaveBalances,
    required List<ShortLeaveModel> permissions,
  }) = _Success;
  const factory AdminEmployeeProfileState.error(String messageKey) = _Error;
}
