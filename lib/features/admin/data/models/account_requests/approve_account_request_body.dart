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
    this.shiftId,
    this.position,
    this.employeeCode,
    this.email,
  });

  final String status;
  final String userName;
  final String password;
  final String? role;
  final List<String>? roles;
  final int? departmentId;
  final int? branchId;
  final int? shiftId;
  final String? position;
  final String? employeeCode;
  final String? email;

  factory ApproveAccountRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ApproveAccountRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveAccountRequestBodyToJson(this);
}
