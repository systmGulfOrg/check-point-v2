import 'package:json_annotation/json_annotation.dart';

part 'employee_check_out_request_body.g.dart';

@JsonSerializable()
class EmployeeCheckOutRequestBody {
  const EmployeeCheckOutRequestBody({
    required this.employeeId,
    this.employeeImage,
  });

  final String employeeId;
  final String? employeeImage;

  factory EmployeeCheckOutRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeCheckOutRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeCheckOutRequestBodyToJson(this);
}
