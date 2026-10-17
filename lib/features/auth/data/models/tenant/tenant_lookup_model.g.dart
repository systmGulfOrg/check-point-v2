// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_lookup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TenantLookupModel _$TenantLookupModelFromJson(Map<String, dynamic> json) =>
    TenantLookupModel(
      valid: json['valid'] as bool?,
      tenantStatus: json['tenantStatus'] as String?,
      reason: json['reason'] as String?,
      tenantId: json['tenantId'] as String?,
      tenantSlug: json['tenantSlug'] as String?,
      companyName: json['companyName'] as String?,
    );

Map<String, dynamic> _$TenantLookupModelToJson(TenantLookupModel instance) =>
    <String, dynamic>{
      'valid': instance.valid,
      'tenantStatus': instance.tenantStatus,
      'reason': instance.reason,
      'tenantId': instance.tenantId,
      'tenantSlug': instance.tenantSlug,
      'companyName': instance.companyName,
    };
