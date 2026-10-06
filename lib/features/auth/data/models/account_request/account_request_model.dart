// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

part 'account_request_model.g.dart';

@JsonSerializable()
class AccountRequestModel {
  const AccountRequestModel({
    required this.name,
    required this.mobileId,
    this.fullName,
    this.deviceId,
    this.deviceToken = '',
    this.tenantSlug,
    this.nationalId,
    this.phone,
    this.deviceModel,
    this.osVersion,
    this.accountType,
    this.siteId,
    this.notes,
  });

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'fullName')
  final String? fullName;

  @JsonKey(name: 'mobileId')
  final String mobileId;

  @JsonKey(name: 'deviceId')
  final String? deviceId;

  @JsonKey(name: 'deviceToken')
  final String deviceToken;

  @JsonKey(name: 'tenantSlug')
  final String? tenantSlug;

  @JsonKey(name: 'nationalId')
  final String? nationalId;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'deviceModel')
  final String? deviceModel;

  @JsonKey(name: 'osVersion')
  final String? osVersion;

  @JsonKey(name: 'accountType')
  final String? accountType;

  @JsonKey(name: 'siteId')
  final String? siteId;

  @JsonKey(name: 'notes')
  final String? notes;

  String get effectiveName => fullName ?? name;
  String get effectiveDeviceId => deviceId ?? mobileId;

  factory AccountRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountRequestModelToJson(this);
}
