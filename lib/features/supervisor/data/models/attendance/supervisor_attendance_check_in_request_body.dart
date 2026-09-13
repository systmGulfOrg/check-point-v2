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

  @JsonKey(name: 'employeeId')
  final String employeeIdd;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final double latitude;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final double longitude;
  final String area;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String clockInTime;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String attendanceDate;
  final String? employeeImage;
  final String? customerId;

  factory SupervisorAttendanceCheckInRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SupervisorAttendanceCheckInRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SupervisorAttendanceCheckInRequestBodyToJson(this);
}
