// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_signup_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrialSignupResultModel _$TrialSignupResultModelFromJson(
  Map<String, dynamic> json,
) => TrialSignupResultModel(
  value: json['value'] == null
      ? null
      : TrialSignupModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$TrialSignupResultModelToJson(
  TrialSignupResultModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
