import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_action_repo.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_timeoff_service.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_leave_requests_use_case.dart';
import 'employee_leave_requests_state.dart';

class EmployeeLeaveRequestsCubit extends SafeCubit<EmployeeLeaveRequestsState> {
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
    result.when(
      success: (data) => safeEmit(EmployeeLeaveRequestsState.success(data)),
      failure: (failure) =>
          safeEmit(EmployeeLeaveRequestsState.error(failure.messageKey)),
    );
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
      safeEmit(EmployeeLeaveRequestsState.leaveTypesLoaded(types));
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      safeEmit(EmployeeLeaveRequestsState.error(failure.messageKey));
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
      safeEmit(EmployeeLeaveRequestsState.publicHolidaysLoaded(holidays));
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      safeEmit(EmployeeLeaveRequestsState.error(failure.messageKey));
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
      safeEmit(
        const EmployeeLeaveRequestsState.actionSuccess(
          'Leave request submitted successfully',
        ),
      );
      await loadOdooLeaveRequests();
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      safeEmit(EmployeeLeaveRequestsState.error(failure.messageKey));
    }
  }

  Future<void> submitLeaveRequest({
    required String startDate,
    required String endDate,
    required String reason,
    required String remark,
    required String leaveRequestType,
    String? attachmentUrl,
  }) async {
    emit(const EmployeeLeaveRequestsState.loading());
    final result = await leaveRequestsUseCase.submitLeaveRequest(
      startDate: startDate,
      endDate: endDate,
      reason: reason,
      remark: remark,
      leaveRequestType: leaveRequestType,
      attachmentUrl: attachmentUrl,
    );
    await result.when(
      success: (_) async {
        safeEmit(
          const EmployeeLeaveRequestsState.actionSuccess(
            'employee.leaves.submitSuccess',
          ),
        );
        await loadLeaveRequests();
      },
      failure: (failure) async =>
          safeEmit(EmployeeLeaveRequestsState.error(failure.messageKey)),
    );
  }

  Future<void> loadOdooLeaveRequests({String? stateFilter}) async {
    emit(const EmployeeLeaveRequestsState.loading());
    try {
      final reqs = await leaveRequestsUseCase.getOdooLeaveRequests(
        stateFilter: stateFilter,
      );
      safeEmit(EmployeeLeaveRequestsState.odooSuccess(reqs));
    } catch (e) {
      final failure = ApiFailureMapper.map(e);
      safeEmit(EmployeeLeaveRequestsState.error(failure.messageKey));
    }
  }

  Future<void> deleteLeaveRequest(dynamic id) async {
    emit(const EmployeeLeaveRequestsState.loading());
    final result = await actionRepo.deleteLeaveRequest(id);
    await result.when(
      success: (_) async {
        await loadLeaveRequests();
        safeEmit(
          const EmployeeLeaveRequestsState.actionSuccess(
            'Leave request deleted successfully',
          ),
        );
      },
      failure: (failure) async =>
          safeEmit(EmployeeLeaveRequestsState.error(failure.messageKey)),
    );
  }
}
