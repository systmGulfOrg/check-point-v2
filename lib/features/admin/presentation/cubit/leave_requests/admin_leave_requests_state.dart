import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';

part 'admin_leave_requests_state.freezed.dart';

@freezed
abstract class AdminLeaveRequestsState with _$AdminLeaveRequestsState {
  const factory AdminLeaveRequestsState.initial() = _Initial;
  const factory AdminLeaveRequestsState.loading() = _Loading;
  const factory AdminLeaveRequestsState.success({
    @Default([]) List<AdminLeaveRequestModel> requests,
    @Default([]) List<LeaveTypeModel> leaveTypes,
  }) = _Success;
  const factory AdminLeaveRequestsState.actionSuccess(String message) =
      _ActionSuccess;
  const factory AdminLeaveRequestsState.error(String messageKey) = _Error;
}
