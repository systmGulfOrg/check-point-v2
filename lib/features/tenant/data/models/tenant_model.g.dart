// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantModelImpl _$$TenantModelImplFromJson(Map<String, dynamic> json) =>
    _$TenantModelImpl(
      tenantId: json['tenantId'] as String?,
      tenantCode: json['tenantCode'] as String?,
      companyName: json['companyName'] as String?,
      logoUrl: json['logoUrl'] as String?,
      baseUrl: json['baseUrl'] as String?,
      status: json['status'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      description: json['description'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orgModel: json['orgModel'] as String?,
    );

Map<String, dynamic> _$$TenantModelImplToJson(_$TenantModelImpl instance) =>
    <String, dynamic>{
      'tenantId': instance.tenantId,
      'tenantCode': instance.tenantCode,
      'companyName': instance.companyName,
      'logoUrl': instance.logoUrl,
      'baseUrl': instance.baseUrl,
      'status': instance.status,
      'isActive': instance.isActive,
      'description': instance.description,
      'roles': instance.roles,
      'orgModel': instance.orgModel,
    };

_$TenantLookupResponseModelImpl _$$TenantLookupResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$TenantLookupResponseModelImpl(
  isSuccess: json['isSuccess'] as bool? ?? false,
  status: (json['status'] as num?)?.toInt(),
  value: json['value'] == null
      ? null
      : TenantModel.fromJson(json['value'] as Map<String, dynamic>),
  successMessage: json['successMessage'] as String?,
  errors: json['errors'] as List<dynamic>? ?? const [],
);

Map<String, dynamic> _$$TenantLookupResponseModelImplToJson(
  _$TenantLookupResponseModelImpl instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'status': instance.status,
  'value': instance.value,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
