// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_lookup_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TenantLookupResultModel _$TenantLookupResultModelFromJson(
  Map<String, dynamic> json,
) => TenantLookupResultModel(
  value: json['value'] == null
      ? null
      : TenantLookupModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$TenantLookupResultModelToJson(
  TenantLookupResultModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
