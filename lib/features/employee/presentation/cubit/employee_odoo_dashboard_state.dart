import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/services/odoo_timeoff_service.dart';

part 'employee_odoo_dashboard_state.freezed.dart';

@freezed
class EmployeeOdooDashboardState with _$EmployeeOdooDashboardState {
  const factory EmployeeOdooDashboardState.initial() =
      EmployeeOdooDashboardStateInitial;
  const factory EmployeeOdooDashboardState.loading() =
      EmployeeOdooDashboardStateLoading;
  const factory EmployeeOdooDashboardState.success({
    required Map<String, dynamic> status,
    required OdooMyAttendanceData attendanceData,
    required List<OdooLeaveRequest> leaveRequests,
  }) = EmployeeOdooDashboardStateSuccess;
  const factory EmployeeOdooDashboardState.error(String messageKey) =
      EmployeeOdooDashboardStateError;
}
