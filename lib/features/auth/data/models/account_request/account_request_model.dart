import 'package:json_annotation/json_annotation.dart';

part 'account_request_model.g.dart';

@JsonSerializable()
class AccountRequestModel {
  const AccountRequestModel({
    required this.name,
    required this.mobileId,
    required this.deviceToken,
  });

  final String name;
  final String mobileId;
  final String deviceToken;

  factory AccountRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountRequestModelToJson(this);
}
