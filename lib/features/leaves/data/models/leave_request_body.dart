import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_request_body.freezed.dart';
part 'leave_request_body.g.dart';

@freezed
class LeaveRequestBody with _$LeaveRequestBody {
  const factory LeaveRequestBody({
    required String leaveTypeId,
    required DateTime startDate,
    required DateTime endDate,
    String? reason,
    String? attachmentUrl,
  }) = _LeaveRequestBody;

  factory LeaveRequestBody.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestBodyFromJson(json);
}
