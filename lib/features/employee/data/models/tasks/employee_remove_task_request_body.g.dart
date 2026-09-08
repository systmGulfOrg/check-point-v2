// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_remove_task_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeRemoveTaskRequestBody _$EmployeeRemoveTaskRequestBodyFromJson(
  Map<String, dynamic> json,
) => EmployeeRemoveTaskRequestBody(
  taskId: (json['taskId'] as num).toInt(),
  employeeId: json['employeeId'] as String,
);

Map<String, dynamic> _$EmployeeRemoveTaskRequestBodyToJson(
  EmployeeRemoveTaskRequestBody instance,
) => <String, dynamic>{
  'taskId': instance.taskId,
  'employeeId': instance.employeeId,
};
