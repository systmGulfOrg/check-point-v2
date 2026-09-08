import 'package:json_annotation/json_annotation.dart';

part 'employee_leave_request_body.g.dart';

@JsonSerializable()
class EmployeeLeaveRequestBody {
  const EmployeeLeaveRequestBody({
    required this.employeeId,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    this.reason,
  });

  final String employeeId;
  final String leaveType;
  final String fromDate;
  final String toDate;
  final String? reason;

  factory EmployeeLeaveRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeLeaveRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeLeaveRequestBodyToJson(this);
}
