// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_work_policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteWorkPolicyModel _$RemoteWorkPolicyModelFromJson(
  Map<String, dynamic> json,
) => RemoteWorkPolicyModel(
  id: json['id'] as String,
  name: json['name'] as String,
  allowedDays: (json['allowedDays'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  onsiteDays:
      (json['onsiteDays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  policyType: json['policyType'] as String? ?? 'remote',
  workingHoursStart: json['workingHoursStart'] as String?,
  workingHoursEnd: json['workingHoursEnd'] as String?,
  allowedDelayTime: (json['allowedDelayTime'] as num?)?.toInt(),
  requiresLocation: json['requiresLocation'] as bool? ?? true,
  allowedRadiusM: (json['allowedRadiusM'] as num?)?.toInt(),
  maxDaysPerWeek: (json['maxDaysPerWeek'] as num?)?.toInt(),
  isActive: json['isActive'] as bool? ?? true,
);
