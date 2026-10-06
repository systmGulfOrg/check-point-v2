// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRequestModel _$AccountRequestModelFromJson(Map<String, dynamic> json) =>
    AccountRequestModel(
      name: json['name'] as String,
      mobileId: json['mobileId'] as String,
      fullName: json['fullName'] as String?,
      deviceId: json['deviceId'] as String?,
      deviceToken: json['deviceToken'] as String? ?? '',
      tenantSlug: json['tenantSlug'] as String?,
      nationalId: json['nationalId'] as String?,
      phone: json['phone'] as String?,
      deviceModel: json['deviceModel'] as String?,
      osVersion: json['osVersion'] as String?,
      accountType: json['accountType'] as String?,
      siteId: json['siteId'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AccountRequestModelToJson(
  AccountRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'fullName': instance.fullName,
  'mobileId': instance.mobileId,
  'deviceId': instance.deviceId,
  'deviceToken': instance.deviceToken,
  'tenantSlug': instance.tenantSlug,
  'nationalId': instance.nationalId,
  'phone': instance.phone,
  'deviceModel': instance.deviceModel,
  'osVersion': instance.osVersion,
  'accountType': instance.accountType,
  'siteId': instance.siteId,
  'notes': instance.notes,
};
