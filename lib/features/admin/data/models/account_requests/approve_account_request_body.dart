import 'package:json_annotation/json_annotation.dart';

part 'approve_account_request_body.g.dart';

@JsonSerializable()
class ApproveAccountRequestBody {
  const ApproveAccountRequestBody({
    required this.userName,
    required this.password,
    this.status = 'Approved',
    this.role,
    this.roles,
    this.departmentId,
    this.branchId,
    this.position,
    this.employeeCode,
    this.email,
    this.nationalId,
    this.workSystem,
    this.remoteWorkPolicyId,
  });

  final String status;
  final String userName;
  final String password;
  final String? role;
  final List<String>? roles;
  final int? departmentId;
  final int? branchId;
  final String? position;
  final String? employeeCode;
  final String? email;
  final String? nationalId;
  final String? workSystem;
  final String? remoteWorkPolicyId;

  factory ApproveAccountRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ApproveAccountRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveAccountRequestBodyToJson(this);
}
