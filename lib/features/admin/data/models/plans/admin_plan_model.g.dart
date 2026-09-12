// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminPlanModel _$AdminPlanModelFromJson(Map<String, dynamic> json) =>
    AdminPlanModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      assignedEmployeeId: json['assignedEmployeeId'] as String?,
      assignedEmployeeName: json['assignedEmployeeName'] as String?,
      notes: json['note'] as String?,
      planDate: json['planDate'] as String?,
      planType: json['planType'] as String?,
      status: json['status'] as String?,
      departmentId: (json['departmentId'] as num?)?.toInt(),
      departmentName: json['departmentName'] as String?,
    );

Map<String, dynamic> _$AdminPlanModelToJson(AdminPlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'assignedEmployeeId': instance.assignedEmployeeId,
      'assignedEmployeeName': instance.assignedEmployeeName,
      'note': instance.notes,
      'planDate': instance.planDate,
      'planType': instance.planType,
      'status': instance.status,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
    };

PlansResponseModel _$PlansResponseModelFromJson(Map<String, dynamic> json) =>
    PlansResponseModel(
      value: json['value'] == null
          ? null
          : PlansPageModel.fromJson(json['value'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
      successMessage: json['successMessage'] as String?,
    );

Map<String, dynamic> _$PlansResponseModelToJson(PlansResponseModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isSuccess': instance.isSuccess,
      'successMessage': instance.successMessage,
    };

SinglePlanResponseModel _$SinglePlanResponseModelFromJson(
  Map<String, dynamic> json,
) => SinglePlanResponseModel(
  value: json['value'] == null
      ? null
      : AdminPlanModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
);

Map<String, dynamic> _$SinglePlanResponseModelToJson(
  SinglePlanResponseModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
};

PlansPageModel _$PlansPageModelFromJson(Map<String, dynamic> json) =>
    PlansPageModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => AdminPlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AdminPlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlansPageModelToJson(PlansPageModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

CreatePlanRequestBody _$CreatePlanRequestBodyFromJson(
  Map<String, dynamic> json,
) => CreatePlanRequestBody(
  title: json['title'] as String,
  description: json['description'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  assignedEmployeeId: json['assignedEmployeeId'] as String,
  departmentId: (json['departmentId'] as num?)?.toInt(),
);

Map<String, dynamic> _$CreatePlanRequestBodyToJson(
  CreatePlanRequestBody instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'assignedEmployeeId': instance.assignedEmployeeId,
  'departmentId': instance.departmentId,
};
