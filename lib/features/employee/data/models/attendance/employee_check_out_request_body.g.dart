// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_check_out_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeCheckOutRequestBody _$EmployeeCheckOutRequestBodyFromJson(
  Map<String, dynamic> json,
) => EmployeeCheckOutRequestBody(
  employeeId: json['employeeId'] as String,
  employeeImage: json['employeeImage'] as String?,
  location: json['location'] as String?,
  note: json['note'] as String?,
  coordinates: (json['coordinates'] as List<dynamic>?)
      ?.map((e) => AttendanceCoordinate.fromJson(e as Map<String, dynamic>))
      .toList(),
  mockLocationDetected: json['mockLocationDetected'] as bool?,
);

Map<String, dynamic> _$EmployeeCheckOutRequestBodyToJson(
  EmployeeCheckOutRequestBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'employeeImage': instance.employeeImage,
  'location': instance.location,
  'note': instance.note,
  'mockLocationDetected': instance.mockLocationDetected,
  'coordinates': instance.coordinates,
};
