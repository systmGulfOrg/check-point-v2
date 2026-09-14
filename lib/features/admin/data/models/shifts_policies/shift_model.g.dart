// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftModel _$ShiftModelFromJson(Map<String, dynamic> json) => ShiftModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  branchesCount: (json['branchesCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$ShiftModelToJson(ShiftModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'branchesCount': instance.branchesCount,
    };

ShiftResponseModel _$ShiftResponseModelFromJson(Map<String, dynamic> json) =>
    ShiftResponseModel(
      value: json['value'] == null
          ? null
          : ShiftPageModel.fromJson(json['value'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
      successMessage: json['successMessage'] as String?,
    );

Map<String, dynamic> _$ShiftResponseModelToJson(ShiftResponseModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isSuccess': instance.isSuccess,
      'successMessage': instance.successMessage,
    };

ShiftPageModel _$ShiftPageModelFromJson(Map<String, dynamic> json) =>
    ShiftPageModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ShiftModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ShiftModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShiftPageModelToJson(ShiftPageModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

AddShiftRequestBody _$AddShiftRequestBodyFromJson(Map<String, dynamic> json) =>
    AddShiftRequestBody(
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AddShiftRequestBodyToJson(
  AddShiftRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
};

AssignShiftsRequestBody _$AssignShiftsRequestBodyFromJson(
  Map<String, dynamic> json,
) => AssignShiftsRequestBody(
  shiftId: (json['shiftId'] as num).toInt(),
  branchIds: (json['branchIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$AssignShiftsRequestBodyToJson(
  AssignShiftsRequestBody instance,
) => <String, dynamic>{
  'shiftId': instance.shiftId,
  'branchIds': instance.branchIds,
};
