import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_balance_model.freezed.dart';
part 'leave_balance_model.g.dart';

@freezed
class LeaveBalanceModel with _$LeaveBalanceModel {
  const factory LeaveBalanceModel({
    required String id,
    required String leaveTypeId,
    required String leaveTypeName,
    required int year,
    required int totalAllocated,
    required int usedBalance,
    required int remainingBalance,
    required int carriedOver,
  }) = _LeaveBalanceModel;

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceModelFromJson(json);
}
