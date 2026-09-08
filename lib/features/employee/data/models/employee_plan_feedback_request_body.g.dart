// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_plan_feedback_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeePlanFeedbackRequestBody _$EmployeePlanFeedbackRequestBodyFromJson(
  Map<String, dynamic> json,
) => EmployeePlanFeedbackRequestBody(
  status: json['status'] as String,
  customerPlanId: (json['customerPlanId'] as num).toInt(),
  imageUrl: json['imageUrl'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$EmployeePlanFeedbackRequestBodyToJson(
  EmployeePlanFeedbackRequestBody instance,
) => <String, dynamic>{
  'status': instance.status,
  'customerPlanId': instance.customerPlanId,
  'imageUrl': instance.imageUrl,
  'notes': instance.notes,
};
