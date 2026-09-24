import 'package:json_annotation/json_annotation.dart';

part 'add_employee_request_body.g.dart';

@JsonSerializable()
class AddEmployeeRequestBody {
  const AddEmployeeRequestBody({
    required this.name,
    required this.username,
    required this.password,
    required this.position,
    required this.mobileId,
    required this.role,
    required this.departmentId,
    required this.branchId,
    required this.shiftId,
    this.roles,
    this.deviceToken,
    this.phone,
    this.email,
    this.employeeCode,
    this.canAddAttendance,
    this.canAddPlan,
    this.leaveBalance,
    this.workSystem,
    this.remoteWorkPolicyId,
    this.directManagerId,
    this.managerId,
  });

  final String name;
  final String username;
  final String password;
  final String position;
  final String mobileId;
  final String role;
  final List<String>? roles;
  final int departmentId;
  final int branchId;
  final int shiftId;
  final List<String>? deviceToken;
  final String? phone;
  final String? email;
  final String? employeeCode;
  final bool? canAddAttendance;
  final bool? canAddPlan;
  final int? leaveBalance;
  final String? workSystem;
  final String? remoteWorkPolicyId;
  final String? directManagerId;
  final String? managerId;

  factory AddEmployeeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddEmployeeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddEmployeeRequestBodyToJson(this);
}
