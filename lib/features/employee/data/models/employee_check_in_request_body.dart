import 'package:json_annotation/json_annotation.dart';

part 'employee_check_in_request_body.g.dart';

@JsonSerializable()
class EmployeeCheckInRequestBody {
  const EmployeeCheckInRequestBody({
    required this.employeeIdd,
    this.customerId,
    this.shiftId,
    this.area,
    this.location,
    this.coordinates,
    this.employeeImage,
  });

  final String employeeIdd;
  final String? customerId;
  final int? shiftId;
  final String? area;
  final String? location;
  final List<AttendanceCoordinate>? coordinates;
  final String? employeeImage;

  factory EmployeeCheckInRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeCheckInRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeCheckInRequestBodyToJson(this);
}

@JsonSerializable()
class AttendanceCoordinate {
  const AttendanceCoordinate({this.latitude, this.longitude});

  final double? latitude;
  final double? longitude;

  factory AttendanceCoordinate.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceCoordinateToJson(this);
}
