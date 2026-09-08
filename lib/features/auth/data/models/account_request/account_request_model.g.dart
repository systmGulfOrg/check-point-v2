// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRequestModel _$AccountRequestModelFromJson(Map<String, dynamic> json) =>
    AccountRequestModel(
      name: json['name'] as String,
      mobileId: json['mobileId'] as String,
      deviceToken: json['deviceToken'] as String,
    );

Map<String, dynamic> _$AccountRequestModelToJson(
  AccountRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'mobileId': instance.mobileId,
  'deviceToken': instance.deviceToken,
};
