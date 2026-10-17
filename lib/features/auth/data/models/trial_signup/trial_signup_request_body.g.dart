// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_signup_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrialSignupRequestBody _$TrialSignupRequestBodyFromJson(
  Map<String, dynamic> json,
) => TrialSignupRequestBody(
  companyName: json['companyName'] as String,
  slug: json['slug'] as String,
  contactEmail: json['contactEmail'] as String,
  adminName: json['adminName'] as String,
  adminUserName: json['adminUserName'] as String,
  password: json['password'] as String,
  acceptTerms: json['acceptTerms'] as bool,
  contactPhone: json['contactPhone'] as String?,
  country: json['country'] as String?,
  timezone: json['timezone'] as String? ?? 'Asia/Riyadh',
  locale: json['locale'] as String? ?? 'ar',
);

Map<String, dynamic> _$TrialSignupRequestBodyToJson(
  TrialSignupRequestBody instance,
) => <String, dynamic>{
  'companyName': instance.companyName,
  'slug': instance.slug,
  'contactEmail': instance.contactEmail,
  'contactPhone': instance.contactPhone,
  'country': instance.country,
  'timezone': instance.timezone,
  'adminName': instance.adminName,
  'adminUserName': instance.adminUserName,
  'password': instance.password,
  'acceptTerms': instance.acceptTerms,
  'locale': instance.locale,
};
