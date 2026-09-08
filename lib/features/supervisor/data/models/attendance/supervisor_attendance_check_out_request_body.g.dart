// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supervisor_attendance_check_out_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupervisorAttendanceCheckOutRequestBody
_$SupervisorAttendanceCheckOutRequestBodyFromJson(Map<String, dynamic> json) =>
    SupervisorAttendanceCheckOutRequestBody(
      employeeId: json['employeeId'] as String,
      employeeImage: json['employeeImage'] as String?,
    );

Map<String, dynamic> _$SupervisorAttendanceCheckOutRequestBodyToJson(
  SupervisorAttendanceCheckOutRequestBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'employeeImage': instance.employeeImage,
};
