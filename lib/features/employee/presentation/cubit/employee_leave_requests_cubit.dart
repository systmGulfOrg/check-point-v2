import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/auth/auth_session_storage.dart';
import '../../../../core/network/api_result.dart';
import '../../data/repos/employee_action_repo.dart';
import '../../data/services/odoo_timeoff_service.dart';
import 'employee_leave_requests_state.dart';

class EmployeeLeaveRequestsCubit extends Cubit<EmployeeLeaveRequestsState> {
  EmployeeLeaveRequestsCubit({
    required this.actionRepo,
    required this.odooTimeOffService,
    required this.sessionStorage,
  }) : super(const EmployeeLeaveRequestsState.initial());

  final EmployeeActionRepo actionRepo;
  final OdooTimeOffService odooTimeOffService;
  final AuthSessionStorage sessionStorage;

  List<OdooLeaveType> leaveTypes = [];
  OdooLeaveType? selectedLeaveType;
  List<OdooPublicHoliday> publicHolidays = [];

  Future<void> loadLeaveRequests() async {
    emit(const EmployeeLeaveRequestsState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final result = await actionRepo.getAllLeaveRequests(employeeId);
    switch (result) {
      case Success(:final data):
        emit(EmployeeLeaveRequestsState.success(data));
      case Failure(:final failure):
        emit(EmployeeLeaveRequestsState.error(failure.messageKey));
    }
  }

  Future<void> loadLeaveTypes() async {
    emit(const EmployeeLeaveRequestsState.loading());
    try {
      final types = await odooTimeOffService.getLeaveTypes();
      leaveTypes = types;
      if (types.isNotEmpty && selectedLeaveType == null) {
        selectedLeaveType = types.first;
      }
      emit(EmployeeLeaveRequestsState.leaveTypesLoaded(types));
    } catch (e) {
      emit(EmployeeLeaveRequestsState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> loadPublicHolidays({String? dateFrom, String? dateTo}) async {
    emit(const EmployeeLeaveRequestsState.loading());
    try {
      final holidays = await odooTimeOffService.getPublicHolidays(
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
      publicHolidays = holidays;
      emit(EmployeeLeaveRequestsState.publicHolidaysLoaded(holidays));
    } catch (e) {
      emit(EmployeeLeaveRequestsState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> submitOdooLeaveRequest({
    required String dateFrom,
    required String dateTo,
    String? reason,
  }) async {
    emit(const EmployeeLeaveRequestsState.loading());
    if (selectedLeaveType == null) {
      emit(const EmployeeLeaveRequestsState.error('please select a leave type'));
      return;
    }
    final employeeId = await sessionStorage.readUserId() ?? '';
    try {
      await odooTimeOffService.submitLeaveRequest(
        employeeId: employeeId,
        leaveTypeId: selectedLeaveType!.id,
        dateFrom: dateFrom,
        dateTo: dateTo,
        reason: reason,
      );
      emit(const EmployeeLeaveRequestsState.actionSuccess(
        'Leave request submitted successfully',
      ));
      await loadOdooLeaveRequests();
    } catch (e) {
      emit(EmployeeLeaveRequestsState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> loadOdooLeaveRequests({String? stateFilter}) async {
    emit(const EmployeeLeaveRequestsState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    try {
      final reqs = await odooTimeOffService.getMyLeaveRequests(
        employeeId: employeeId,
        state: stateFilter,
      );
      emit(EmployeeLeaveRequestsState.odooSuccess(reqs));
    } catch (e) {
      emit(EmployeeLeaveRequestsState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> deleteLeaveRequest(int id) async {
    emit(const EmployeeLeaveRequestsState.loading());
    final result = await actionRepo.deleteLeaveRequest(id);
    switch (result) {
      case Success():
        await loadLeaveRequests();
        emit(const EmployeeLeaveRequestsState.actionSuccess(
          'Leave request deleted successfully',
        ));
      case Failure(:final failure):
        emit(EmployeeLeaveRequestsState.error(failure.messageKey));
    }
  }
}
