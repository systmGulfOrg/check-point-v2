import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_leave_requests_repo.dart';
import 'admin_leave_requests_state.dart';

class AdminLeaveRequestsCubit extends Cubit<AdminLeaveRequestsState> {
  AdminLeaveRequestsCubit({required this.leaveRequestsRepo})
    : super(const AdminLeaveRequestsState.initial());

  final AdminLeaveRequestsRepo leaveRequestsRepo;

  List<AdminLeaveRequestModel> _cachedRequests = [];
  List<LeaveTypeModel> _cachedLeaveTypes = [];

  List<AdminLeaveRequestModel> get requests => _cachedRequests;
  List<LeaveTypeModel> get leaveTypes => _cachedLeaveTypes;

  Future<void> loadAll() async {
    emit(const AdminLeaveRequestsState.loading());
    final requestsResult = await leaveRequestsRepo.getAllLeaveRequests();
    final typesResult = await leaveRequestsRepo.getLeaveTypes();

    switch (requestsResult) {
      case Success(:final data):
        _cachedRequests = data;
      case Failure():
        break;
    }

    switch (typesResult) {
      case Success(:final data):
        _cachedLeaveTypes = data;
      case Failure():
        break;
    }

    if (requestsResult is Failure && typesResult is Failure) {
      emit(
        AdminLeaveRequestsState.error(
          (requestsResult as Failure).failure.messageKey,
        ),
      );
      return;
    }

    emit(
      AdminLeaveRequestsState.success(
        requests: _cachedRequests,
        leaveTypes: _cachedLeaveTypes,
      ),
    );
  }

  Future<void> loadRequests() async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.getAllLeaveRequests();
    switch (result) {
      case Success(:final data):
        _cachedRequests = data;
        emit(
          AdminLeaveRequestsState.success(
            requests: _cachedRequests,
            leaveTypes: _cachedLeaveTypes,
          ),
        );
      case Failure(:final failure):
        emit(AdminLeaveRequestsState.error(failure.messageKey));
    }
  }

  Future<void> loadLeaveTypes() async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.getLeaveTypes();
    switch (result) {
      case Success(:final data):
        _cachedLeaveTypes = data;
        emit(
          AdminLeaveRequestsState.success(
            requests: _cachedRequests,
            leaveTypes: _cachedLeaveTypes,
          ),
        );
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
        await loadAll();
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
        await loadAll();
        return true;
      case Failure(:final failure):
        emit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> addLeaveType(AddLeaveTypeRequestBody body) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.addLeaveType(body);
    switch (result) {
      case Success():
        await loadAll();
        return true;
      case Failure(:final failure):
        emit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> editLeaveType(int id, AddLeaveTypeRequestBody body) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.editLeaveType(id, body);
    switch (result) {
      case Success():
        await loadAll();
        return true;
      case Failure(:final failure):
        emit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> deleteLeaveType(int id) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.deleteLeaveType(id);
    switch (result) {
      case Success():
        await loadAll();
        return true;
      case Failure(:final failure):
        emit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
