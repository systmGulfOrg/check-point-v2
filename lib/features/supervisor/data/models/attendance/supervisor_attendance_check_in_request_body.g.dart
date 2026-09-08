// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supervisor_attendance_check_in_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupervisorAttendanceCheckInRequestBody
_$SupervisorAttendanceCheckInRequestBodyFromJson(Map<String, dynamic> json) =>
    SupervisorAttendanceCheckInRequestBody(
      employeeIdd: json['employeeIdd'] as String,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      area: json['area'] as String? ?? 'Office',
      clockInTime: json['clockInTime'] as String? ?? '',
      attendanceDate: json['attendanceDate'] as String? ?? '',
      employeeImage: json['employeeImage'] as String?,
      customerId: json['customerId'] as String?,
    );

Map<String, dynamic> _$SupervisorAttendanceCheckInRequestBodyToJson(
  SupervisorAttendanceCheckInRequestBody instance,
) => <String, dynamic>{
  'employeeIdd': instance.employeeIdd,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'area': instance.area,
  'clockInTime': instance.clockInTime,
  'attendanceDate': instance.attendanceDate,
  'employeeImage': instance.employeeImage,
  'customerId': instance.customerId,
};
