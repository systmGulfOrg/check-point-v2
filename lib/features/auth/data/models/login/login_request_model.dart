// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  const LoginRequestModel({
    required this.userName,
    required this.password,
    required this.mobileId,
    this.tenantSlug,
    this.deviceModel,
    this.osVersion,
    this.latitude,
    this.longitude,
  });

  @JsonKey(name: 'userName')
  final String userName;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'mobileId')
  final String mobileId;

  @JsonKey(name: 'tenantSlug')
  final String? tenantSlug;

  @JsonKey(name: 'deviceModel')
  final String? deviceModel;

  @JsonKey(name: 'osVersion')
  final String? osVersion;

  @JsonKey(name: 'latitude')
  final double? latitude;

  @JsonKey(name: 'longitude')
  final double? longitude;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
