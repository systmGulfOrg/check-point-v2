import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';

part 'supervisor_leave_requests_state.freezed.dart';

@freezed
class SupervisorLeaveRequestsState with _$SupervisorLeaveRequestsState {
  const factory SupervisorLeaveRequestsState.initial() =
      SupervisorLeaveRequestsInitial;
  const factory SupervisorLeaveRequestsState.loading() =
      SupervisorLeaveRequestsLoading;
  const factory SupervisorLeaveRequestsState.success({
    required List<AdminLeaveRequestModel> requests,
    String? statusFilter,
  }) = SupervisorLeaveRequestsSuccess;
  const factory SupervisorLeaveRequestsState.actionSuccess(String message) =
      SupervisorLeaveRequestsActionSuccess;
  const factory SupervisorLeaveRequestsState.error(String messageKey) =
      SupervisorLeaveRequestsError;
}
