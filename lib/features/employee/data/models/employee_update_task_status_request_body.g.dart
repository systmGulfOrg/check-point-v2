// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_update_task_status_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeUpdateTaskStatusRequestBody
_$EmployeeUpdateTaskStatusRequestBodyFromJson(Map<String, dynamic> json) =>
    EmployeeUpdateTaskStatusRequestBody(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$EmployeeUpdateTaskStatusRequestBodyToJson(
  EmployeeUpdateTaskStatusRequestBody instance,
) => <String, dynamic>{'id': instance.id, 'status': instance.status};
