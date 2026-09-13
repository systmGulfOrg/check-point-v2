import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/employee/data/models/leave_requests/employee_leave_request_body.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_action_repo.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_timeoff_service.dart';

class EmployeeLeaveRequestsUseCase {
  EmployeeLeaveRequestsUseCase({
    required this.actionRepo,
    required this.odooTimeOffService,
    required this.sessionStorage,
  });

  final EmployeeActionRepo actionRepo;
  final OdooTimeOffService odooTimeOffService;
  final AuthSessionStorage sessionStorage;

  Future<ApiResult<List<AdminLeaveRequestModel>>>
  getNativeLeaveRequests() async {
    final employeeId = await sessionStorage.readUserId() ?? '';
    return actionRepo.getAllLeaveRequests(employeeId);
  }

  Future<ApiResult<void>> submitLeaveRequest({
    required String startDate,
    required String endDate,
    required String reason,
    required String remark,
    required String leaveRequestType,
  }) async {
    final employeeId = await sessionStorage.readUserId() ?? '';
    return actionRepo.createLeaveRequest(
      EmployeeLeaveRequestBody(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
        remark: remark,
        leaveRequestType: leaveRequestType,
      ),
    );
  }

  Future<List<OdooLeaveRequest>> getOdooLeaveRequests({
    String? stateFilter,
  }) async {
    final employeeId = await sessionStorage.readUserId() ?? '';
    return odooTimeOffService.getMyLeaveRequests(
      employeeId: employeeId,
      state: stateFilter,
    );
  }

  Future<void> submitOdooLeaveRequest({
    required int leaveTypeId,
    required String dateFrom,
    required String dateTo,
    String? reason,
  }) async {
    final employeeId = await sessionStorage.readUserId() ?? '';
    await odooTimeOffService.submitLeaveRequest(
      employeeId: employeeId,
      leaveTypeId: leaveTypeId,
      dateFrom: dateFrom,
      dateTo: dateTo,
      reason: reason,
    );
  }
}
