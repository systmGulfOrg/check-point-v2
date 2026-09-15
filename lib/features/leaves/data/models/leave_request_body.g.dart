// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveRequestBodyImpl _$$LeaveRequestBodyImplFromJson(
  Map<String, dynamic> json,
) => _$LeaveRequestBodyImpl(
  leaveTypeId: json['leaveTypeId'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  reason: json['reason'] as String?,
  attachmentUrl: json['attachmentUrl'] as String?,
);

Map<String, dynamic> _$$LeaveRequestBodyImplToJson(
  _$LeaveRequestBodyImpl instance,
) => <String, dynamic>{
  'leaveTypeId': instance.leaveTypeId,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'reason': instance.reason,
  'attachmentUrl': instance.attachmentUrl,
};
