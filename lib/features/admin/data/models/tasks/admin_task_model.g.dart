// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminTaskModel _$AdminTaskModelFromJson(Map<String, dynamic> json) =>
    AdminTaskModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      assignedEmployeeId: json['assignedEmployeeId'] as String?,
      assignedEmployeeName: json['assignedEmployeeName'] as String?,
    );

Map<String, dynamic> _$AdminTaskModelToJson(AdminTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'assignedEmployeeId': instance.assignedEmployeeId,
      'assignedEmployeeName': instance.assignedEmployeeName,
    };

TasksResponseModel _$TasksResponseModelFromJson(Map<String, dynamic> json) =>
    TasksResponseModel(
      value: json['value'] == null
          ? null
          : TasksPageModel.fromJson(json['value'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
      successMessage: json['successMessage'] as String?,
    );

Map<String, dynamic> _$TasksResponseModelToJson(TasksResponseModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isSuccess': instance.isSuccess,
      'successMessage': instance.successMessage,
    };

TasksListResponseModel _$TasksListResponseModelFromJson(
  Map<String, dynamic> json,
) => TasksListResponseModel(
  value: (json['value'] as List<dynamic>?)
      ?.map((e) => AdminTaskModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
);

Map<String, dynamic> _$TasksListResponseModelToJson(
  TasksListResponseModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
};

TasksPageModel _$TasksPageModelFromJson(Map<String, dynamic> json) =>
    TasksPageModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => AdminTaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AdminTaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TasksPageModelToJson(TasksPageModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

AddTaskRequestBody _$AddTaskRequestBodyFromJson(Map<String, dynamic> json) =>
    AddTaskRequestBody(
      title: json['title'] as String,
      description: json['description'] as String,
      assignedEmployeeId: json['assignedEmployeeId'] as String?,
      dueDate: json['dueDate'] as String?,
      priorityStatus: json['priorityStatus'] as String?,
      status: json['status'] as String?,
      departmentId: (json['departmentId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddTaskRequestBodyToJson(AddTaskRequestBody instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'assignedEmployeeId': instance.assignedEmployeeId,
      'dueDate': instance.dueDate,
      'priorityStatus': instance.priorityStatus,
      'status': instance.status,
      'departmentId': instance.departmentId,
    };

AssignTaskRequestBody _$AssignTaskRequestBodyFromJson(
  Map<String, dynamic> json,
) => AssignTaskRequestBody(
  taskId: (json['taskId'] as num).toInt(),
  employeeId: json['employeeId'] as String,
);

Map<String, dynamic> _$AssignTaskRequestBodyToJson(
  AssignTaskRequestBody instance,
) => <String, dynamic>{
  'taskId': instance.taskId,
  'employeeId': instance.employeeId,
};
