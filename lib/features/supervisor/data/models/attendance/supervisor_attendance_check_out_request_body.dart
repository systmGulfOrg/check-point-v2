import 'package:json_annotation/json_annotation.dart';

part 'supervisor_attendance_check_out_request_body.g.dart';

@JsonSerializable()
class SupervisorAttendanceCheckOutRequestBody {
  const SupervisorAttendanceCheckOutRequestBody({
    required this.employeeId,
    this.employeeImage,
  });

  final String employeeId;
  final String? employeeImage;

  factory SupervisorAttendanceCheckOutRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SupervisorAttendanceCheckOutRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SupervisorAttendanceCheckOutRequestBodyToJson(this);
}
