// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_remove_plan_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeRemovePlanRequestBody _$EmployeeRemovePlanRequestBodyFromJson(
  Map<String, dynamic> json,
) => EmployeeRemovePlanRequestBody(
  customerPlanId: (json['customerPlanId'] as num).toInt(),
  employeeId: json['employeeId'] as String,
);

Map<String, dynamic> _$EmployeeRemovePlanRequestBodyToJson(
  EmployeeRemovePlanRequestBody instance,
) => <String, dynamic>{
  'customerPlanId': instance.customerPlanId,
  'employeeId': instance.employeeId,
};
