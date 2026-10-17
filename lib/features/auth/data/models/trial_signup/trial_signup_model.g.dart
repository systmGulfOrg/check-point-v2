// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrialSignupModel _$TrialSignupModelFromJson(Map<String, dynamic> json) =>
    TrialSignupModel(
      companyName: json['companyName'] as String?,
      slug: json['slug'] as String?,
      adminUserName: json['adminUserName'] as String?,
      trialEndsAt: json['trialEndsAt'] == null
          ? null
          : DateTime.parse(json['trialEndsAt'] as String),
      seatLimit: (json['seatLimit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TrialSignupModelToJson(TrialSignupModel instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'slug': instance.slug,
      'adminUserName': instance.adminUserName,
      'trialEndsAt': instance.trialEndsAt?.toIso8601String(),
      'seatLimit': instance.seatLimit,
    };
