import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_timeoff_service.dart';
import 'employee_odoo_dashboard_state.dart';

class EmployeeOdooDashboardCubit extends Cubit<EmployeeOdooDashboardState> {
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

      emit(
        EmployeeOdooDashboardState.success(
          status: status,
          attendanceData: attendanceData,
          leaveRequests: leaveRequests,
        ),
      );
    } catch (e) {
      emit(
        EmployeeOdooDashboardState.error(
          e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  void changePeriod(String newPeriod) {
    period = newPeriod;
    fetchDashboardData();
  }
}
