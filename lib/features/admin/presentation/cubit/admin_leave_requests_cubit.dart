import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../data/models/admin_leave_request_model.dart';
import '../../data/repos/admin_leave_requests_repo.dart';
import 'admin_leave_requests_state.dart';

class AdminLeaveRequestsCubit extends Cubit<AdminLeaveRequestsState> {
  AdminLeaveRequestsCubit({required this.leaveRequestsRepo})
    : super(const AdminLeaveRequestsState.initial());

  final AdminLeaveRequestsRepo leaveRequestsRepo;

  Future<void> loadRequests() async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.getAllLeaveRequests();
    switch (result) {
      case Success(:final data):
        emit(AdminLeaveRequestsState.success(data));
      case Failure(:final failure):
        emit(AdminLeaveRequestsState.error(failure.messageKey));
    }
  }

  Future<bool> updateStatus({
    required int requestId,
    required String status,
  }) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.approveOrRejectLeaveRequest(
      ChangeRequestLeaveStatus(leaveRequestId: requestId, status: status),
    );
    switch (result) {
      case Success():
        await loadRequests();
        emit(
          AdminLeaveRequestsState.actionSuccess(
            'Request status updated successfully',
          ),
        );
        return true;
      case Failure(:final failure):
        emit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> deleteRequest(int requestId) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.deleteLeaveRequest(requestId);
    switch (result) {
      case Success():
        await loadRequests();
        emit(
          const AdminLeaveRequestsState.actionSuccess(
            'Request deleted successfully',
          ),
        );
        return true;
      case Failure(:final failure):
        emit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
