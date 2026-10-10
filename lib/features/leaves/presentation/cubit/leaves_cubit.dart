import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../../data/models/leave_balance_model.dart';
import '../../data/models/leave_request_body.dart';
import '../../data/models/leave_request_model.dart';
import '../../data/models/leave_type_model.dart';
import '../../data/repos/leaves_repo_impl.dart';
import 'leaves_state.dart';

class LeavesCubit extends Cubit<LeavesState> {
  LeavesCubit({required this.leavesRepo}) : super(const LeavesState.initial());

  final LeavesRepoImpl leavesRepo;

  Future<void> loadMyLeaveRequests() => loadLeavesData();

  Future<void> loadOfficialHolidays({int? year}) async {
    emit(const LeavesState.loading());
    final result = await leavesRepo.getOfficialHolidays(year: year);
    result.when(
      success: (holidays) => emit(LeavesState.holidaysLoaded(holidays)),
      failure: (failure) => emit(LeavesState.error(failure.messageKey)),
    );
  }

  Future<bool> rescheduleHoliday({
    required String holidayId,
    required String holidayName,
    required DateTime newDate,
    String? note,
    bool reset = false,
    bool isCancelled = false,
    String? cancelReason,
    List<String>? excludedDepartmentIds,
    List<String>? excludedEmployeeIds,
  }) async {
    final result = await leavesRepo.rescheduleHoliday(
      holidayId: holidayId,
      holidayName: holidayName,
      newDate: newDate,
      note: note,
      reset: reset,
      isCancelled: isCancelled,
      cancelReason: cancelReason,
      excludedDepartmentIds: excludedDepartmentIds,
      excludedEmployeeIds: excludedEmployeeIds,
    );
    return result.when(
      success: (_) async {
        await loadOfficialHolidays();
        return true;
      },
      failure: (failure) {
        emit(LeavesState.error(failure.messageKey));
        return false;
      },
    );
  }

  List<LeaveTypeModel> leaveTypes = [];

  Future<void> loadLeavesData() async {
    emit(const LeavesState.loading());

    final typesResult = await leavesRepo.getLeaveTypes();
    final requestsResult = await leavesRepo.getLeaveRequests();

    final types = typesResult.when(
      success: (data) {
        leaveTypes = data;
        return data;
      },
      failure: (_) => const <LeaveTypeModel>[],
    );
    final requests = requestsResult.when(
      success: (data) => data,
      failure: (_) => const <LeaveRequestModel>[],
    );

    final balancesResult = await leavesRepo.getLeaveBalances(
      types: types,
      requests: requests,
    );
    final balances = balancesResult.when(
      success: (data) => data,
      failure: (_) => const <LeaveBalanceModel>[],
    );

    emit(LeavesState.success(balances, types, requests));
  }

  Future<void> submitLeave(LeaveRequestBody body) async {
    emit(const LeavesState.submitting());
    final result = await leavesRepo.submitLeaveRequest(body);
    switch (result) {
      case Success():
        emit(const LeavesState.submitSuccess());
        await loadLeavesData();
      case Failure(:final failure):
        emit(LeavesState.error(failure.messageKey));
    }
  }

  Future<void> cancelLeave(String id) async {
    emit(const LeavesState.loading());
    final result = await leavesRepo.cancelLeaveRequest(id);
    switch (result) {
      case Success():
        emit(
          const LeavesState.actionSuccess(
            'Leave request cancelled successfully',
          ),
        );
        await loadLeavesData();
      case Failure(:final failure):
        emit(LeavesState.error(failure.messageKey));
    }
  }

  Future<void> deleteLeaveRequest(dynamic id) async {
    emit(const LeavesState.loading());
    final result = await leavesRepo.deleteLeaveRequest(id);
    switch (result) {
      case Success():
        emit(
          const LeavesState.actionSuccess('Leave request deleted successfully'),
        );
        await loadLeavesData();
      case Failure(:final failure):
        emit(LeavesState.error(failure.messageKey));
    }
  }
}
