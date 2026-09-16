import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/leave_balance_model.dart';
import '../../data/models/leave_request_model.dart';
import '../../data/models/leave_type_model.dart';

part 'leaves_state.freezed.dart';

@freezed
class LeavesState with _$LeavesState {
  const factory LeavesState.initial() = _Initial;
  const factory LeavesState.loading() = _Loading;
  const factory LeavesState.success(
    List<LeaveBalanceModel> balances,
    List<LeaveTypeModel> types,
    List<LeaveRequestModel> requests,
  ) = _Success;
  const factory LeavesState.error(String message) = _Error;
  const factory LeavesState.submitting() = _Submitting;
  const factory LeavesState.submitSuccess() = _SubmitSuccess;
  const factory LeavesState.actionSuccess(String message) = _ActionSuccess;
}
