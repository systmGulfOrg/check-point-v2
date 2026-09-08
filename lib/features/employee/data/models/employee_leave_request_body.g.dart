// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_leave_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeLeaveRequestBody _$EmployeeLeaveRequestBodyFromJson(
  Map<String, dynamic> json,
) => EmployeeLeaveRequestBody(
  employeeId: json['employeeId'] as String,
  leaveType: json['leaveType'] as String,
  fromDate: json['fromDate'] as String,
  toDate: json['toDate'] as String,
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$EmployeeLeaveRequestBodyToJson(
  EmployeeLeaveRequestBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'leaveType': instance.leaveType,
  'fromDate': instance.fromDate,
  'toDate': instance.toDate,
  'reason': instance.reason,
};
