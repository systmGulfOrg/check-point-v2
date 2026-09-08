import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_timeoff_service.dart';

part 'employee_leave_requests_state.freezed.dart';

@freezed
class EmployeeLeaveRequestsState with _$EmployeeLeaveRequestsState {
  const factory EmployeeLeaveRequestsState.initial() =
      EmployeeLeaveRequestsStateInitial;
  const factory EmployeeLeaveRequestsState.loading() =
      EmployeeLeaveRequestsStateLoading;
  const factory EmployeeLeaveRequestsState.success(
    List<AdminLeaveRequestModel> leaveRequests,
  ) = EmployeeLeaveRequestsStateSuccess;
  const factory EmployeeLeaveRequestsState.odooSuccess(
    List<OdooLeaveRequest> odooRequests,
  ) = EmployeeLeaveRequestsStateOdooSuccess;
  const factory EmployeeLeaveRequestsState.leaveTypesLoaded(
    List<OdooLeaveType> leaveTypes,
  ) = EmployeeLeaveRequestsStateLeaveTypesLoaded;
  const factory EmployeeLeaveRequestsState.publicHolidaysLoaded(
    List<OdooPublicHoliday> holidays,
  ) = EmployeeLeaveRequestsStatePublicHolidaysLoaded;
  const factory EmployeeLeaveRequestsState.actionSuccess(String message) =
      EmployeeLeaveRequestsStateActionSuccess;
  const factory EmployeeLeaveRequestsState.error(String messageKey) =
      EmployeeLeaveRequestsStateError;
}
