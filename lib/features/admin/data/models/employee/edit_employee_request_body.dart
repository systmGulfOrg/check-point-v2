import 'package:json_annotation/json_annotation.dart';

part 'edit_employee_request_body.g.dart';

@JsonSerializable(includeIfNull: false)
class EditEmployeeRequestBody {
  const EditEmployeeRequestBody({
    this.name,
    this.userName,
    this.password,
    this.position,
    this.mobileId,
    this.role,
    this.roles,
    this.departmentId,
    this.branchId,
    this.shiftId,
    this.phone,
    this.email,
    this.employeeCode,
    this.canAddAttendance,
    this.canAddPlan,
    this.deviceToken,
    this.leaveBalance,
    this.workSystem,
    this.remoteWorkPolicyId,
    this.directManagerId,
    this.managerId,
  });

  final String? name;
  @JsonKey(name: 'username')
  final String? userName;
  final String? password;
  final String? position;
  final String? mobileId;
  final String? role;
  final List<String>? roles;
  final int? departmentId;
  final int? branchId;
  final int? shiftId;
  final String? phone;
  final String? email;
  final String? employeeCode;
  final bool? canAddAttendance;
  final bool? canAddPlan;
  final List<String>? deviceToken;
  final int? leaveBalance;
  final String? workSystem;
  final String? remoteWorkPolicyId;
  final String? directManagerId;
  final String? managerId;

  factory EditEmployeeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EditEmployeeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EditEmployeeRequestBodyToJson(this);
}
