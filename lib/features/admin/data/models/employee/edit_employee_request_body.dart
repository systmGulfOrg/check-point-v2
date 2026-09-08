import 'package:json_annotation/json_annotation.dart';

part 'edit_employee_request_body.g.dart';

@JsonSerializable()
class EditEmployeeRequestBody {
  const EditEmployeeRequestBody({
    required this.name,
    required this.position,
    required this.departmentId,
    required this.branchId,
    required this.role,
    this.userName = '',
    this.password = '',
    this.mobileId = '',
  });

  final String name;
  final String userName;
  final String password;
  final String position;
  final String mobileId;
  final String role;
  final int departmentId;
  final int branchId;

  factory EditEmployeeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EditEmployeeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EditEmployeeRequestBodyToJson(this);
}
