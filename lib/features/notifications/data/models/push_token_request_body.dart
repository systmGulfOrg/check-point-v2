import 'package:json_annotation/json_annotation.dart';

part 'push_token_request_body.g.dart';

/// Body for `POST /api/v2/devices/tokens`.
@JsonSerializable()
class PushTokenRequestBody {
  const PushTokenRequestBody({required this.token, this.platform});

  final String token;

  /// One of 'ios' | 'android' | 'web', matching the backend's enum.
  final String? platform;

  factory PushTokenRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PushTokenRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PushTokenRequestBodyToJson(this);
}

/// Body for `DELETE /api/v2/devices/tokens` (deregister by token value, used
/// on logout — the app never learns the row id the token was registered
/// under).
@JsonSerializable()
class DeregisterPushTokenRequestBody {
  const DeregisterPushTokenRequestBody({required this.token});

  final String token;

  factory DeregisterPushTokenRequestBody.fromJson(Map<String, dynamic> json) =>
      _$DeregisterPushTokenRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DeregisterPushTokenRequestBodyToJson(this);
}
