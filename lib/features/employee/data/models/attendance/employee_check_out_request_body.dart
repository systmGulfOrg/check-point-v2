import 'package:json_annotation/json_annotation.dart';

import 'employee_check_in_request_body.dart';

part 'employee_check_out_request_body.g.dart';

@JsonSerializable()
class EmployeeCheckOutRequestBody {
  const EmployeeCheckOutRequestBody({
    required this.employeeId,
    this.employeeImage,
    this.location,
    this.note,
    this.coordinates,
    this.mockLocationDetected,
  });

  final String employeeId;
  final String? employeeImage;
  final String? location;
  final String? note;
  final bool? mockLocationDetected;
  final List<AttendanceCoordinate>? coordinates;

  factory EmployeeCheckOutRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeCheckOutRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeCheckOutRequestBodyToJson(this);
}
