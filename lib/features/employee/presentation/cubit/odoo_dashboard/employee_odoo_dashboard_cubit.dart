import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_timeoff_service.dart';
import 'employee_odoo_dashboard_state.dart';

class EmployeeOdooDashboardCubit extends SafeCubit<EmployeeOdooDashboardState> {
  EmployeeOdooDashboardCubit({
    required this.odooTimeOffService,
    required this.sessionStorage,
  }) : super(const EmployeeOdooDashboardState.initial());

  final OdooTimeOffService odooTimeOffService;
  final AuthSessionStorage sessionStorage;

  String period = 'month';

  Future<void> fetchDashboardData() async {
    emit(const EmployeeOdooDashboardState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    try {
      final results = await Future.wait([
        odooTimeOffService.getAttendanceStatus(employeeId: employeeId),
        odooTimeOffService.getMyAttendance(
          employeeId: employeeId,
          period: period,
        ),
        odooTimeOffService.getMyLeaveRequests(employeeId: employeeId),
      ]);

      final status = results[0] as Map<String, dynamic>;
      final attendanceData = results[1] as OdooMyAttendanceData;
      final leaveRequests = results[2] as List<OdooLeaveRequest>;

      safeEmit(
        EmployeeOdooDashboardState.success(
          status: status,
          attendanceData: attendanceData,
          leaveRequests: leaveRequests,
        ),
      );
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      safeEmit(EmployeeOdooDashboardState.error(failure.messageKey));
    }
  }

  void changePeriod(String newPeriod) {
    period = newPeriod;
    fetchDashboardData();
  }
}
