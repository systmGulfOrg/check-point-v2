// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeModel _$LeaveTypeModelFromJson(Map<String, dynamic> json) =>
    LeaveTypeModel(
      id: (json['id'] as num?)?.toInt(),
      typeName: json['typeName'] as String?,
      maxDaysPerYear: (json['maxDaysPerYear'] as num?)?.toInt(),
      isPaid: json['isPaid'] as bool?,
      requiresAttachment: json['requiresAttachment'] as bool?,
    );

Map<String, dynamic> _$LeaveTypeModelToJson(LeaveTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeName': instance.typeName,
      'maxDaysPerYear': instance.maxDaysPerYear,
      'isPaid': instance.isPaid,
      'requiresAttachment': instance.requiresAttachment,
    };

LeaveTypesResponseModel _$LeaveTypesResponseModelFromJson(
  Map<String, dynamic> json,
) => LeaveTypesResponseModel(
  value: json['value'] == null
      ? null
      : LeaveTypesPageModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
);

Map<String, dynamic> _$LeaveTypesResponseModelToJson(
  LeaveTypesResponseModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
};

LeaveTypesPageModel _$LeaveTypesPageModelFromJson(Map<String, dynamic> json) =>
    LeaveTypesPageModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => LeaveTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LeaveTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LeaveTypesPageModelToJson(
  LeaveTypesPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'data': instance.data,
  'totalCount': instance.totalCount,
};

AddLeaveTypeRequestBody _$AddLeaveTypeRequestBodyFromJson(
  Map<String, dynamic> json,
) => AddLeaveTypeRequestBody(
  typeName: json['typeName'] as String,
  maxDaysPerYear: (json['maxDaysPerYear'] as num?)?.toInt(),
  isPaid: json['isPaid'] as bool? ?? true,
  requiresAttachment: json['requiresAttachment'] as bool? ?? false,
);

Map<String, dynamic> _$AddLeaveTypeRequestBodyToJson(
  AddLeaveTypeRequestBody instance,
) => <String, dynamic>{
  'typeName': instance.typeName,
  'maxDaysPerYear': instance.maxDaysPerYear,
  'isPaid': instance.isPaid,
  'requiresAttachment': instance.requiresAttachment,
};
