import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/employee/data/models/leave_requests/employee_leave_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_leave_requests_repo.dart';
import 'supervisor_leave_requests_state.dart';

class SupervisorLeaveRequestsCubit extends Cubit<SupervisorLeaveRequestsState> {
  SupervisorLeaveRequestsCubit({
    required this.leaveRequestsRepo,
    required this.sessionStorage,
  }) : super(const SupervisorLeaveRequestsState.initial());

  final SupervisorLeaveRequestsRepo leaveRequestsRepo;
  final AuthSessionStorage sessionStorage;
  List<AdminLeaveRequestModel> allRequests = const [];
  List<LeaveTypeModel> leaveTypes = const [];
  String? statusFilter;
  String userRole = 'Employee';
  String currentUserId = '';

  Future<void> initRole() async {
    userRole = await sessionStorage.readUserRole() ?? 'Employee';
    currentUserId = await sessionStorage.readUserId() ?? '';
  }

  Future<List<LeaveTypeModel>> loadLeaveTypes() async {
    final result = await leaveRequestsRepo.getLeaveTypes();
    return result.when(
      success: (data) {
        leaveTypes = data;
        return data;
      },
      failure: (_) => leaveTypes,
    );
  }

  Future<bool> submitLeaveRequest({
    required String startDate,
    required String endDate,
    required String reason,
    required String remark,
    required String leaveRequestType,
  }) async {
    emit(const SupervisorLeaveRequestsState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final result = await leaveRequestsRepo.createLeaveRequest(
      EmployeeLeaveRequestBody(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
        remark: remark,
        leaveRequestType: leaveRequestType,
      ),
    );
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

  Future<void> loadRequests({int? departmentId, String? type}) async {
    emit(const SupervisorLeaveRequestsState.loading());
    if (userRole == 'Employee' || currentUserId.isEmpty) {
      await initRole();
    }
    final result = await leaveRequestsRepo.getLeaveRequests(
      departmentId: departmentId,
      type: type,
    );
    switch (result) {
      case Success(:final data):
        // Hide supervisor's own requests
        allRequests = data.where((r) => r.employeeId != currentUserId).toList();
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
    final filterLower = statusFilter!.toLowerCase();
    return allRequests
        .where((r) => r.status?.toLowerCase() == filterLower)
        .toList();
  }

  Future<void> loadLeaveRequests({int? departmentId, String? type}) =>
      loadRequests(departmentId: departmentId, type: type);

  Future<bool> approveRequest(String ulid, String role) async {
    emit(const SupervisorLeaveRequestsState.loading());
    final action = role == 'Admin' ? 'ApproveHR' : 'ApproveManager';
    final result = await leaveRequestsRepo.approveOrRejectLeaveRequestV2(
      ulid,
      action,
      null,
    );
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

  Future<bool> rejectRequest(String ulid, String role, String reason) async {
    emit(const SupervisorLeaveRequestsState.loading());
    final action = role == 'Admin' ? 'RejectHR' : 'RejectManager';
    final result = await leaveRequestsRepo.approveOrRejectLeaveRequestV2(
      ulid,
      action,
      reason,
    );
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
}
