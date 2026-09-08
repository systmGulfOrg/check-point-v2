import 'package:json_annotation/json_annotation.dart';

part 'employee_change_password_request_body.g.dart';

@JsonSerializable()
class EmployeeChangePasswordRequestBody {
  const EmployeeChangePasswordRequestBody({
    required this.employeeId,
    required this.oldPassword,
    required this.newPassword,
  });

  final String employeeId;
  final String oldPassword;
  final String newPassword;

  factory EmployeeChangePasswordRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$EmployeeChangePasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EmployeeChangePasswordRequestBodyToJson(this);
}
