// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantConfigModelImpl _$$TenantConfigModelImplFromJson(
  Map<String, dynamic> json,
) => _$TenantConfigModelImpl(
  tenantId: json['tenantId'] as String,
  companyName: json['companyName'] as String,
  enabledFeatures: (json['enabledFeatures'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  orgModel: json['orgModel'] as String?,
  timezone: json['timezone'] as String?,
  locale: json['locale'] as String?,
);

Map<String, dynamic> _$$TenantConfigModelImplToJson(
  _$TenantConfigModelImpl instance,
) => <String, dynamic>{
  'tenantId': instance.tenantId,
  'companyName': instance.companyName,
  'enabledFeatures': instance.enabledFeatures,
  'orgModel': instance.orgModel,
  'timezone': instance.timezone,
  'locale': instance.locale,
};

_$TenantConfigApiResponseImpl _$$TenantConfigApiResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TenantConfigApiResponseImpl(
  isSuccess: json['isSuccess'] as bool? ?? false,
  status: (json['status'] as num?)?.toInt(),
  value: json['value'] == null
      ? null
      : TenantConfigModel.fromJson(json['value'] as Map<String, dynamic>),
  successMessage: json['successMessage'] as String?,
  errors: json['errors'] as List<dynamic>? ?? const [],
);

Map<String, dynamic> _$$TenantConfigApiResponseImplToJson(
  _$TenantConfigApiResponseImpl instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'status': instance.status,
  'value': instance.value,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
