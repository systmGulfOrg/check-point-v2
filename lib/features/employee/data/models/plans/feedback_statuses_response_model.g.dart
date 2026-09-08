// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_statuses_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackStatusesResponseModel _$FeedbackStatusesResponseModelFromJson(
  Map<String, dynamic> json,
) => FeedbackStatusesResponseModel(
  value: (json['value'] as List<dynamic>?)?.map((e) => e as String).toList(),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
);

Map<String, dynamic> _$FeedbackStatusesResponseModelToJson(
  FeedbackStatusesResponseModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
};
