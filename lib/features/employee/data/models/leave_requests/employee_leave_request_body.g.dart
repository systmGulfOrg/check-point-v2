// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_leave_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeLeaveRequestBody _$EmployeeLeaveRequestBodyFromJson(
  Map<String, dynamic> json,
) => EmployeeLeaveRequestBody(
  employeeId: json['employeeId'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  reason: json['reason'] as String,
  remark: json['remark'] as String,
  leaveRequestType: json['leaveRequestType'] as String,
);

Map<String, dynamic> _$EmployeeLeaveRequestBodyToJson(
  EmployeeLeaveRequestBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'reason': instance.reason,
  'remark': instance.remark,
  'leaveRequestType': instance.leaveRequestType,
};
