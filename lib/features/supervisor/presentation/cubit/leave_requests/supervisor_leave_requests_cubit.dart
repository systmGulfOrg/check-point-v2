import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
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
  String currentEmployeeId = '';
  String currentUserName = '';

  bool isActionableForMe(AdminLeaveRequestModel request) {
    final status = request.status?.toLowerCase() ?? '';
    if (status != 'pending') return false;

    final isOwnRequest =
        (currentUserId.isNotEmpty && request.employeeId == currentUserId) ||
        (currentEmployeeId.isNotEmpty &&
            request.employeeId == currentEmployeeId) ||
        (currentUserName.isNotEmpty &&
            request.employeeName?.trim().toLowerCase() ==
                currentUserName.trim().toLowerCase());
    if (isOwnRequest) return false;

    final directManagerId = request.directManagerId?.trim().toLowerCase();
    final directManagerName = request.directManagerName?.trim().toLowerCase();
    final currentEmp = currentEmployeeId.trim().toLowerCase();
    final currentUsr = currentUserId.trim().toLowerCase();
    final currentNm = currentUserName.trim().toLowerCase();

    if (directManagerId != null && directManagerId.isNotEmpty) {
      if (currentEmp.isNotEmpty && directManagerId == currentEmp) return true;
      if (currentUsr.isNotEmpty && directManagerId == currentUsr) return true;
      if (currentNm.isNotEmpty &&
          directManagerName != null &&
          directManagerName.isNotEmpty) {
        if (directManagerName == currentNm ||
            directManagerName.contains(currentNm) ||
            currentNm.contains(directManagerName)) {
          return true;
        }
      }
      return false;
    }

    if (directManagerName != null &&
        directManagerName.isNotEmpty &&
        directManagerName != '-') {
      if (currentNm.isNotEmpty &&
          (directManagerName == currentNm ||
              directManagerName.contains(currentNm) ||
              currentNm.contains(directManagerName))) {
        return true;
      }
      return false;
    }

    return userRole == 'Admin' || userRole == 'Supervisor';
  }

  int get pendingCount => allRequests.where(isActionableForMe).length;

  Future<void> initRole() async {
    userRole = await sessionStorage.readUserRole() ?? 'Employee';
    currentUserId = await sessionStorage.readUserId() ?? '';
    currentEmployeeId = await sessionStorage.readEmployeeId() ?? currentUserId;
    currentUserName = await sessionStorage.readUserName() ?? '';
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
    String? attachmentUrl,
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
        attachmentUrl: attachmentUrl,
      ),
    );
    return result.when(
      success: (_) async {
        await loadRequests();
        return true;
      },
      failure: (failure) {
        emit(SupervisorLeaveRequestsState.error(failure.messageKey));
        emit(
          SupervisorLeaveRequestsState.success(
            requests: _filteredRequests,
            statusFilter: statusFilter,
          ),
        );
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
    result.when(
      success: (data) {
        allRequests = data;
        emit(
          SupervisorLeaveRequestsState.success(
            requests: _filteredRequests,
            statusFilter: statusFilter,
          ),
        );
      },
      failure: (failure) {
        emit(SupervisorLeaveRequestsState.error(failure.messageKey));
        if (allRequests.isNotEmpty) {
          emit(
            SupervisorLeaveRequestsState.success(
              requests: _filteredRequests,
              statusFilter: statusFilter,
            ),
          );
        }
      },
    );
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

  Future<bool> approveRequest(
    String ulid,
    String role, {
    String? currentStatus,
  }) async {
    emit(const SupervisorLeaveRequestsState.loading());
    final reqStatus = (currentStatus ?? '').toLowerCase();
    final action = reqStatus == 'pendinghr'
        ? 'ApproveHR'
        : (reqStatus == 'pending'
              ? 'ApproveManager'
              : (role == 'Admin' ? 'ApproveHR' : 'ApproveManager'));
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
        emit(
          SupervisorLeaveRequestsState.success(
            requests: _filteredRequests,
            statusFilter: statusFilter,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> rejectRequest(
    String ulid,
    String role,
    String reason, {
    String? currentStatus,
  }) async {
    emit(const SupervisorLeaveRequestsState.loading());
    final reqStatus = (currentStatus ?? '').toLowerCase();
    final action = reqStatus == 'pendinghr'
        ? 'RejectHR'
        : (reqStatus == 'pending'
              ? 'RejectManager'
              : (role == 'Admin' ? 'RejectHR' : 'RejectManager'));
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
        emit(
          SupervisorLeaveRequestsState.success(
            requests: _filteredRequests,
            statusFilter: statusFilter,
          ),
        );
        return false;
      },
    );
  }
}
