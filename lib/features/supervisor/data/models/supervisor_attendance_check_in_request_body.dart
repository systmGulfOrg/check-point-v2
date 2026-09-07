import 'package:json_annotation/json_annotation.dart';

part 'supervisor_attendance_check_in_request_body.g.dart';

@JsonSerializable()
class SupervisorAttendanceCheckInRequestBody {
  const SupervisorAttendanceCheckInRequestBody({
    required this.employeeIdd,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.area = 'Office',
    this.clockInTime = '',
    this.attendanceDate = '',
    this.employeeImage,
    this.customerId,
  });

  final String employeeIdd;
  final double latitude;
  final double longitude;
  final String area;
  final String clockInTime;
  final String attendanceDate;
  final String? employeeImage;
  final String? customerId;

  factory SupervisorAttendanceCheckInRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SupervisorAttendanceCheckInRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SupervisorAttendanceCheckInRequestBodyToJson(this);
}
