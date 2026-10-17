import 'package:json_annotation/json_annotation.dart';

part 'trial_signup_model.g.dart';

@JsonSerializable()
class TrialSignupModel {
  const TrialSignupModel({
    this.companyName,
    this.slug,
    this.adminUserName,
    this.trialEndsAt,
    this.seatLimit,
  });

  final String? companyName;
  final String? slug;
  final String? adminUserName;
  final DateTime? trialEndsAt;
  final int? seatLimit;

  factory TrialSignupModel.fromJson(Map<String, dynamic> json) =>
      _$TrialSignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrialSignupModelToJson(this);
}
