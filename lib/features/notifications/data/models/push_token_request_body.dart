import 'package:json_annotation/json_annotation.dart';

part 'push_token_request_body.g.dart';

@JsonSerializable()
class PushTokenRequestBody {
  const PushTokenRequestBody({required this.token, this.platform});

  final String token;

  final String? platform;

  factory PushTokenRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PushTokenRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PushTokenRequestBodyToJson(this);
}

@JsonSerializable()
class DeregisterPushTokenRequestBody {
  const DeregisterPushTokenRequestBody({required this.token});

  final String token;

  factory DeregisterPushTokenRequestBody.fromJson(Map<String, dynamic> json) =>
      _$DeregisterPushTokenRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DeregisterPushTokenRequestBodyToJson(this);
}
