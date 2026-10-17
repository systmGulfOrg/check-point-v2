import 'package:json_annotation/json_annotation.dart';

part 'trial_signup_request_body.g.dart';

@JsonSerializable()
class TrialSignupRequestBody {
  const TrialSignupRequestBody({
    required this.companyName,
    required this.slug,
    required this.contactEmail,
    required this.adminName,
    required this.adminUserName,
    required this.password,
    required this.acceptTerms,
    this.contactPhone,
    this.country,
    this.timezone = 'Asia/Riyadh',
    this.locale = 'ar',
  });

  final String companyName;
  final String slug;
  final String contactEmail;
  final String? contactPhone;
  final String? country;
  final String timezone;
  final String adminName;
  final String adminUserName;
  final String password;
  final bool acceptTerms;
  final String locale;

  factory TrialSignupRequestBody.fromJson(Map<String, dynamic> json) =>
      _$TrialSignupRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TrialSignupRequestBodyToJson(this);
}
