import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_leave_requests_repo.dart';
import 'admin_leave_requests_state.dart';

class AdminLeaveRequestsCubit extends SafeCubit<AdminLeaveRequestsState> {
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

    final requests = requestsResult.when(
      success: (data) => data,
      failure: (_) => null,
    );
    final types = typesResult.when(
      success: (data) => data,
      failure: (_) => null,
    );

    if (requests == null && types == null) {
      requestsResult.when(
        success: (_) {},
        failure: (failure) =>
            safeEmit(AdminLeaveRequestsState.error(failure.messageKey)),
      );
      return;
    }

    _cachedRequests = requests ?? const [];
    _cachedLeaveTypes = types ?? const [];

    safeEmit(
      AdminLeaveRequestsState.success(
        requests: _cachedRequests,
        leaveTypes: _cachedLeaveTypes,
      ),
    );
  }

  Future<void> loadRequests() async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.getAllLeaveRequests();
    result.when(
      success: (data) {
        _cachedRequests = data;
        safeEmit(
          AdminLeaveRequestsState.success(
            requests: _cachedRequests,
            leaveTypes: _cachedLeaveTypes,
          ),
        );
      },
      failure: (failure) =>
          safeEmit(AdminLeaveRequestsState.error(failure.messageKey)),
    );
  }

  Future<void> loadLeaveTypes() async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.getLeaveTypes();
    result.when(
      success: (data) {
        _cachedLeaveTypes = data;
        safeEmit(
          AdminLeaveRequestsState.success(
            requests: _cachedRequests,
            leaveTypes: _cachedLeaveTypes,
          ),
        );
      },
      failure: (failure) =>
          safeEmit(AdminLeaveRequestsState.error(failure.messageKey)),
    );
  }

  Future<bool> updateStatus({
    required int requestId,
    required String status,
  }) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.approveOrRejectLeaveRequest(
      ChangeRequestLeaveStatus(leaveRequestId: requestId, status: status),
    );
    return result.when(
      success: (_) async {
        await loadAll();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deleteRequest(dynamic requestId) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.deleteLeaveRequest(requestId);
    return result.when(
      success: (_) async {
        await loadAll();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> addLeaveType(AddLeaveTypeRequestBody body) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.addLeaveType(body);
    return result.when(
      success: (_) async {
        await loadAll();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> editLeaveType(int id, AddLeaveTypeRequestBody body) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.editLeaveType(id, body);
    return result.when(
      success: (_) async {
        await loadAll();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deleteLeaveType(int id) async {
    emit(const AdminLeaveRequestsState.loading());
    final result = await leaveRequestsRepo.deleteLeaveType(id);
    return result.when(
      success: (_) async {
        await loadAll();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminLeaveRequestsState.error(failure.messageKey));
        return false;
      },
    );
  }
}
