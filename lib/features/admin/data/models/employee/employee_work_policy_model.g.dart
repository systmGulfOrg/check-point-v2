// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_work_policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeWorkPolicyModel _$EmployeeWorkPolicyModelFromJson(
  Map<String, dynamic> json,
) => EmployeeWorkPolicyModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  policyType: json['policyType'] as String?,
  allowedDays: (json['allowedDays'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  onsiteDays: (json['onsiteDays'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  workingHoursStart: json['workingHoursStart'] as String?,
  workingHoursEnd: json['workingHoursEnd'] as String?,
  allowedDelayTime: (json['allowedDelayTime'] as num?)?.toInt(),
);

Map<String, dynamic> _$EmployeeWorkPolicyModelToJson(
  EmployeeWorkPolicyModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'policyType': instance.policyType,
  'allowedDays': instance.allowedDays,
  'onsiteDays': instance.onsiteDays,
  'workingHoursStart': instance.workingHoursStart,
  'workingHoursEnd': instance.workingHoursEnd,
  'allowedDelayTime': instance.allowedDelayTime,
};
