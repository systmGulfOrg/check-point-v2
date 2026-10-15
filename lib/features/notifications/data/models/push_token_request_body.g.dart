// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_token_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushTokenRequestBody _$PushTokenRequestBodyFromJson(
  Map<String, dynamic> json,
) => PushTokenRequestBody(
  token: json['token'] as String,
  platform: json['platform'] as String?,
);

Map<String, dynamic> _$PushTokenRequestBodyToJson(
  PushTokenRequestBody instance,
) => <String, dynamic>{'token': instance.token, 'platform': instance.platform};

DeregisterPushTokenRequestBody _$DeregisterPushTokenRequestBodyFromJson(
  Map<String, dynamic> json,
) => DeregisterPushTokenRequestBody(token: json['token'] as String);

Map<String, dynamic> _$DeregisterPushTokenRequestBodyToJson(
  DeregisterPushTokenRequestBody instance,
) => <String, dynamic>{'token': instance.token};
