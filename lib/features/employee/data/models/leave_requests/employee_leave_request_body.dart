import 'package:json_annotation/json_annotation.dart';

part 'employee_leave_request_body.g.dart';

@JsonSerializable()
class EmployeeLeaveRequestBody {
  const EmployeeLeaveRequestBody({
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.remark,
    required this.leaveRequestType,
    this.attachmentUrl,
  });

  final String employeeId;
  final String startDate;
  final String endDate;
  final String reason;
  final String remark;
  final String leaveRequestType;
  final String? attachmentUrl;

  factory EmployeeLeaveRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeLeaveRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeLeaveRequestBodyToJson(this);
}
