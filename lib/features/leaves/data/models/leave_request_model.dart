import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_request_model.freezed.dart';
part 'leave_request_model.g.dart';

@freezed
class LeaveRequestModel with _$LeaveRequestModel {
  const factory LeaveRequestModel({
    required String id,
    required String leaveTypeId,
    String? leaveTypeName,
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
    required int totalDays,
    required String status,
    String? reason,
    String? attachmentUrl,
    DateTime? createdAt,
    String? directManagerId,
    String? directManagerName,
    bool? hasDirectManager,
    String? rejectionReason,
    List<dynamic>? timeline,
    String? managerId,
    String? managerName,
    DateTime? managerActionAt,
    String? managerRejectionReason,
    String? hrId,
    String? hrName,
    DateTime? hrActionAt,
    String? hrRejectionReason,
  }) = _LeaveRequestModel;

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestModelFromJson(json);
}
