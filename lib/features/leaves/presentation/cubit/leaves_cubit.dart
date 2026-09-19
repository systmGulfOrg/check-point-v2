import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/leave_request_body.dart';
import '../../data/repos/leaves_repo_impl.dart';
import 'leaves_state.dart';

class LeavesCubit extends Cubit<LeavesState> {
  LeavesCubit({required this.leavesRepo}) : super(const LeavesState.initial());

  final LeavesRepoImpl leavesRepo;

  Future<void> loadMyLeaveRequests() => loadLeavesData();

  Future<void> loadLeavesData() async {
    emit(const LeavesState.loading());

    final balancesResult = await leavesRepo.getLeaveBalances();
    final typesResult = await leavesRepo.getLeaveTypes();
    final requestsResult = await leavesRepo.getLeaveRequests();

    balancesResult.when(
      success: (balances) {
        typesResult.when(
          success: (types) {
            requestsResult.when(
              success: (requests) =>
                  emit(LeavesState.success(balances, types, requests)),
              failure: (f) => emit(LeavesState.error(f.messageKey)),
            );
          },
          failure: (f) => emit(LeavesState.error(f.messageKey)),
        );
      },
      failure: (f) => emit(LeavesState.error(f.messageKey)),
    );
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
}
