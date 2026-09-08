// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_change_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeChangePasswordRequestBody _$EmployeeChangePasswordRequestBodyFromJson(
  Map<String, dynamic> json,
) => EmployeeChangePasswordRequestBody(
  employeeId: json['employeeId'] as String,
  oldPassword: json['oldPassword'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$EmployeeChangePasswordRequestBodyToJson(
  EmployeeChangePasswordRequestBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'oldPassword': instance.oldPassword,
  'newPassword': instance.newPassword,
};
