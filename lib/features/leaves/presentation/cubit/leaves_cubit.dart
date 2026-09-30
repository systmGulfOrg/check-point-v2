import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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

  List<LeaveTypeModel> leaveTypes = [];
  List<LeaveBalanceModel> cachedBalances = const [];
  List<LeaveRequestModel> cachedRequests = const [];

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
      failure: (_) => cachedRequests,
    );

    final balancesResult = await leavesRepo.getLeaveBalances(
      types: types,
      requests: requests,
    );
    final balances = balancesResult.when(
      success: (data) => data,
      failure: (_) => cachedBalances,
    );

    cachedBalances = balances;
    cachedRequests = requests;
    emit(LeavesState.success(balances, types, requests));
  }

  Future<void> submitLeave(LeaveRequestBody body) async {
    emit(const LeavesState.submitting());
    final result = await leavesRepo.submitLeaveRequest(body);
    result.when(
      success: (_) {
        emit(const LeavesState.submitSuccess());
        unawaited(loadLeavesData());
      },
      failure: (f) => emit(LeavesState.error(f.messageKey)),
    );
  }

  Future<void> cancelLeave(String id) async {
    emit(const LeavesState.loading());
    final result = await leavesRepo.cancelLeaveRequest(id);
    result.when(
      success: (_) {
        emit(
          const LeavesState.actionSuccess(
            'Leave request cancelled successfully',
          ),
        );
        unawaited(loadLeavesData());
      },
      failure: (f) => emit(LeavesState.error(f.messageKey)),
    );
  }

  Future<void> deleteLeaveRequest(dynamic id) async {
    emit(const LeavesState.loading());
    final result = await leavesRepo.deleteLeaveRequest(id);
    result.when(
      success: (_) {
        emit(
          const LeavesState.actionSuccess(
            'Leave request deleted successfully',
          ),
        );
        unawaited(loadLeavesData());
      },
      failure: (f) => emit(LeavesState.error(f.messageKey)),
    );
  }
}
