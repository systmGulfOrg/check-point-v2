// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_check_in_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeCheckInRequestBody _$EmployeeCheckInRequestBodyFromJson(
  Map<String, dynamic> json,
) => EmployeeCheckInRequestBody(
  employeeIdd: json['employeeId'] as String,
  customerId: json['customerId'] as String?,
  area: json['area'] as String?,
  location: json['location'] as String?,
  coordinates: (json['coordinates'] as List<dynamic>?)
      ?.map((e) => AttendanceCoordinate.fromJson(e as Map<String, dynamic>))
      .toList(),
  employeeImage: json['employeeImage'] as String?,
);

Map<String, dynamic> _$EmployeeCheckInRequestBodyToJson(
  EmployeeCheckInRequestBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeIdd,
  'customerId': instance.customerId,
  'area': instance.area,
  'location': instance.location,
  'coordinates': instance.coordinates,
  'employeeImage': instance.employeeImage,
};

AttendanceCoordinate _$AttendanceCoordinateFromJson(
  Map<String, dynamic> json,
) => AttendanceCoordinate(
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$AttendanceCoordinateToJson(
  AttendanceCoordinate instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
