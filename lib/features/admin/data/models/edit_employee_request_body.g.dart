// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_employee_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditEmployeeRequestBody _$EditEmployeeRequestBodyFromJson(
  Map<String, dynamic> json,
) => EditEmployeeRequestBody(
  name: json['name'] as String,
  position: json['position'] as String,
  departmentId: (json['departmentId'] as num).toInt(),
  branchId: (json['branchId'] as num).toInt(),
  role: json['role'] as String,
  userName: json['userName'] as String? ?? '',
  password: json['password'] as String? ?? '',
  mobileId: json['mobileId'] as String? ?? '',
);

Map<String, dynamic> _$EditEmployeeRequestBodyToJson(
  EditEmployeeRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'userName': instance.userName,
  'password': instance.password,
  'position': instance.position,
  'mobileId': instance.mobileId,
  'role': instance.role,
  'departmentId': instance.departmentId,
  'branchId': instance.branchId,
};
