// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_employee_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddEmployeeRequestBody _$AddEmployeeRequestBodyFromJson(
  Map<String, dynamic> json,
) => AddEmployeeRequestBody(
  name: json['name'] as String,
  username: json['username'] as String,
  password: json['password'] as String,
  position: json['position'] as String,
  mobileId: json['mobileId'] as String,
  role: json['role'] as String,
  departmentId: (json['departmentId'] as num).toInt(),
  branchId: (json['branchId'] as num).toInt(),
  deviceToken: (json['deviceToken'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$AddEmployeeRequestBodyToJson(
  AddEmployeeRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'username': instance.username,
  'password': instance.password,
  'position': instance.position,
  'mobileId': instance.mobileId,
  'role': instance.role,
  'departmentId': instance.departmentId,
  'branchId': instance.branchId,
  'deviceToken': instance.deviceToken,
};
