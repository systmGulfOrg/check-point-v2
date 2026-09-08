import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_leave_requests_repo.dart';
import 'supervisor_leave_requests_state.dart';

class SupervisorLeaveRequestsCubit extends Cubit<SupervisorLeaveRequestsState> {
  SupervisorLeaveRequestsCubit({required this.leaveRequestsRepo})
    : super(const SupervisorLeaveRequestsState.initial());

  final SupervisorLeaveRequestsRepo leaveRequestsRepo;
  List<AdminLeaveRequestModel> allRequests = const [];
  String? statusFilter;

  Future<void> loadRequests({int? departmentId, String? type}) async {
    emit(const SupervisorLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.getLeaveRequests(
      departmentId: departmentId,
      type: type,
    );
    switch (result) {
      case Success(:final data):
        allRequests = data;
        emit(
          SupervisorLeaveRequestsState.success(
            requests: _filteredRequests,
            statusFilter: statusFilter,
          ),
        );
      case Failure(:final failure):
        emit(SupervisorLeaveRequestsState.error(failure.messageKey));
    }
  }

  void filterByStatus(String? status) {
    statusFilter = status;
    emit(
      SupervisorLeaveRequestsState.success(
        requests: _filteredRequests,
        statusFilter: statusFilter,
      ),
    );
  }

  List<AdminLeaveRequestModel> get _filteredRequests {
    if (statusFilter == null ||
        statusFilter!.isEmpty ||
        statusFilter == 'All') {
      return allRequests;
    }
    return allRequests
        .where(
          (r) => (r.status ?? '').toLowerCase() == statusFilter!.toLowerCase(),
        )
        .toList();
  }

  Future<void> loadLeaveRequests({int? departmentId, String? type}) =>
      loadRequests(departmentId: departmentId, type: type);

  Future<bool> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  ) async {
    emit(const SupervisorLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.approveOrRejectLeaveRequest(body);
    return result.when(
      success: (_) async {
        await loadRequests();
        return true;
      },
      failure: (failure) {
        emit(SupervisorLeaveRequestsState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> approveRequest(int id) => approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus(leaveRequestId: id, status: 'Approved'),
  );

  Future<bool> rejectRequest(int id) => approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus(leaveRequestId: id, status: 'Rejected'),
  );
}
