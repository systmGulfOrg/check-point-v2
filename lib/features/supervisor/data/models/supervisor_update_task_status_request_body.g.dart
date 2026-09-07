// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supervisor_update_task_status_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupervisorUpdateTaskStatusRequestBody
_$SupervisorUpdateTaskStatusRequestBodyFromJson(Map<String, dynamic> json) =>
    SupervisorUpdateTaskStatusRequestBody(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$SupervisorUpdateTaskStatusRequestBodyToJson(
  SupervisorUpdateTaskStatusRequestBody instance,
) => <String, dynamic>{'id': instance.id, 'status': instance.status};
