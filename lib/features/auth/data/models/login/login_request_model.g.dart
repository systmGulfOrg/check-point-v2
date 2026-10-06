// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    LoginRequestModel(
      userName: json['userName'] as String,
      password: json['password'] as String,
      mobileId: json['mobileId'] as String,
      tenantSlug: json['tenantSlug'] as String?,
      deviceModel: json['deviceModel'] as String?,
      osVersion: json['osVersion'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'mobileId': instance.mobileId,
      'tenantSlug': instance.tenantSlug,
      'deviceModel': instance.deviceModel,
      'osVersion': instance.osVersion,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
