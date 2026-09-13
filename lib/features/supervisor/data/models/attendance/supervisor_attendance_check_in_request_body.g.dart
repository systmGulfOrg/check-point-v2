// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supervisor_attendance_check_in_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupervisorAttendanceCheckInRequestBody
_$SupervisorAttendanceCheckInRequestBodyFromJson(Map<String, dynamic> json) =>
    SupervisorAttendanceCheckInRequestBody(
      employeeIdd: json['employeeId'] as String,
      area: json['area'] as String? ?? 'Office',
      employeeImage: json['employeeImage'] as String?,
      customerId: json['customerId'] as String?,
    );

Map<String, dynamic> _$SupervisorAttendanceCheckInRequestBodyToJson(
  SupervisorAttendanceCheckInRequestBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeIdd,
  'area': instance.area,
  'employeeImage': instance.employeeImage,
  'customerId': instance.customerId,
};
