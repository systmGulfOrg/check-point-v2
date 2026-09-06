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
    this.deviceToken,
  });

  final String name;
  final String username;
  final String password;
  final String position;
  final String mobileId;
  final String role;
  final int departmentId;
  final int branchId;
  final List<String>? deviceToken;

  factory AddEmployeeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddEmployeeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddEmployeeRequestBodyToJson(this);
}
