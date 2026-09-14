import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_action_repo.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_timeoff_service.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_leave_requests_use_case.dart';
import 'employee_leave_requests_state.dart';

class EmployeeLeaveRequestsCubit extends Cubit<EmployeeLeaveRequestsState> {
  EmployeeLeaveRequestsCubit({
    required this.actionRepo,
    required this.odooTimeOffService,
    required this.leaveRequestsUseCase,
  }) : super(const EmployeeLeaveRequestsState.initial());

  final EmployeeActionRepo actionRepo;
  final OdooTimeOffService odooTimeOffService;
  final EmployeeLeaveRequestsUseCase leaveRequestsUseCase;

  List<LeaveTypeModel> nativeLeaveTypes = [];
  List<OdooLeaveType> leaveTypes = [];
  OdooLeaveType? selectedLeaveType;
  List<OdooPublicHoliday> publicHolidays = [];

  Future<void> loadLeaveRequests() async {
    emit(const EmployeeLeaveRequestsState.loading());
    final result = await leaveRequestsUseCase.getNativeLeaveRequests();
    switch (result) {
      case Success(:final data):
        emit(EmployeeLeaveRequestsState.success(data));
      case Failure(:final failure):
        emit(EmployeeLeaveRequestsState.error(failure.messageKey));
    }
  }

  Future<List<LeaveTypeModel>> loadNativeLeaveTypes() async {
    final result = await leaveRequestsUseCase.getNativeLeaveTypes();
    return result.when(
      success: (data) {
        nativeLeaveTypes = data;
        return data;
      },
      failure: (_) => nativeLeaveTypes,
    );
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
      emit(
        EmployeeLeaveRequestsState.error(
          e.toString().replaceAll('Exception: ', ''),
        ),
      );
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
      emit(
        EmployeeLeaveRequestsState.error(
          e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> submitOdooLeaveRequest({
    required String dateFrom,
    required String dateTo,
    String? reason,
  }) async {
    emit(const EmployeeLeaveRequestsState.loading());
    if (selectedLeaveType == null) {
      emit(
        const EmployeeLeaveRequestsState.error('please select a leave type'),
      );
      return;
    }
    try {
      await leaveRequestsUseCase.submitOdooLeaveRequest(
        leaveTypeId: selectedLeaveType!.id,
        dateFrom: dateFrom,
        dateTo: dateTo,
        reason: reason,
      );
      emit(
        const EmployeeLeaveRequestsState.actionSuccess(
          'Leave request submitted successfully',
        ),
      );
      await loadOdooLeaveRequests();
    } catch (e) {
      emit(
        EmployeeLeaveRequestsState.error(
          e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> submitLeaveRequest({
    required String startDate,
    required String endDate,
    required String reason,
    required String remark,
    required String leaveRequestType,
  }) async {
    emit(const EmployeeLeaveRequestsState.loading());
    final result = await leaveRequestsUseCase.submitLeaveRequest(
      startDate: startDate,
      endDate: endDate,
      reason: reason,
      remark: remark,
      leaveRequestType: leaveRequestType,
    );
    switch (result) {
      case Success():
        emit(
          const EmployeeLeaveRequestsState.actionSuccess(
            'employee.leaves.submitSuccess',
          ),
        );
        await loadLeaveRequests();
      case Failure(:final failure):
        emit(EmployeeLeaveRequestsState.error(failure.messageKey));
    }
  }

  Future<void> loadOdooLeaveRequests({String? stateFilter}) async {
    emit(const EmployeeLeaveRequestsState.loading());
    try {
      final reqs = await leaveRequestsUseCase.getOdooLeaveRequests(
        stateFilter: stateFilter,
      );
      emit(EmployeeLeaveRequestsState.odooSuccess(reqs));
    } catch (e) {
      emit(
        EmployeeLeaveRequestsState.error(
          e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> deleteLeaveRequest(int id) async {
    emit(const EmployeeLeaveRequestsState.loading());
    final result = await actionRepo.deleteLeaveRequest(id);
    switch (result) {
      case Success():
        await loadLeaveRequests();
        emit(
          const EmployeeLeaveRequestsState.actionSuccess(
            'Leave request deleted successfully',
          ),
        );
      case Failure(:final failure):
        emit(EmployeeLeaveRequestsState.error(failure.messageKey));
    }
  }
}
