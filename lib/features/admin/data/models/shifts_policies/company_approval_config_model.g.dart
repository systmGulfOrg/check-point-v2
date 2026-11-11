// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_approval_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyApprovalConfigModelImpl _$$CompanyApprovalConfigModelImplFromJson(
  Map<String, dynamic> json,
) => _$CompanyApprovalConfigModelImpl(
  leaveWorkflow: json['leaveWorkflow'] as String? ?? 'manager_then_hr',
  holdingGracePeriodMinutes:
      (json['holdingGracePeriodMinutes'] as num?)?.toInt() ?? 0,
  adminsObserverOnly: json['adminsObserverOnly'] as bool? ?? true,
  adminCanOverrideHolding: json['adminCanOverrideHolding'] as bool? ?? false,
  enforceLateArrivalNoticeDeadline:
      json['enforceLateArrivalNoticeDeadline'] as bool? ?? false,
  lateArrivalNoticeMinutes:
      (json['lateArrivalNoticeMinutes'] as num?)?.toInt() ?? 60,
  enforceGracePeriodForLateArrival:
      json['enforceGracePeriodForLateArrival'] as bool? ?? false,
  enforceEarlyDepartureDeadline:
      json['enforceEarlyDepartureDeadline'] as bool? ?? false,
  earlyDepartureDeadlinePercent:
      (json['earlyDepartureDeadlinePercent'] as num?)?.toInt() ?? 50,
  allowPermitsOnWeekends: json['allowPermitsOnWeekends'] as bool? ?? true,
  allowPermitsOnHolidays: json['allowPermitsOnHolidays'] as bool? ?? true,
  forceSameDayCasualLeave: json['forceSameDayCasualLeave'] as bool? ?? false,
);

Map<String, dynamic> _$$CompanyApprovalConfigModelImplToJson(
  _$CompanyApprovalConfigModelImpl instance,
) => <String, dynamic>{
  'leaveWorkflow': instance.leaveWorkflow,
  'holdingGracePeriodMinutes': instance.holdingGracePeriodMinutes,
  'adminsObserverOnly': instance.adminsObserverOnly,
  'adminCanOverrideHolding': instance.adminCanOverrideHolding,
  'enforceLateArrivalNoticeDeadline': instance.enforceLateArrivalNoticeDeadline,
  'lateArrivalNoticeMinutes': instance.lateArrivalNoticeMinutes,
  'enforceGracePeriodForLateArrival': instance.enforceGracePeriodForLateArrival,
  'enforceEarlyDepartureDeadline': instance.enforceEarlyDepartureDeadline,
  'earlyDepartureDeadlinePercent': instance.earlyDepartureDeadlinePercent,
  'allowPermitsOnWeekends': instance.allowPermitsOnWeekends,
  'allowPermitsOnHolidays': instance.allowPermitsOnHolidays,
  'forceSameDayCasualLeave': instance.forceSameDayCasualLeave,
};
