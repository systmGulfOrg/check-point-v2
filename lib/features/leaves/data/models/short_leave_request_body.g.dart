// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_leave_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShortLeaveRequestBodyImpl _$$ShortLeaveRequestBodyImplFromJson(
  Map<String, dynamic> json,
) => _$ShortLeaveRequestBodyImpl(
  date: DateTime.parse(json['date'] as String),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  permitType: json['permitType'] as String,
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$$ShortLeaveRequestBodyImplToJson(
  _$ShortLeaveRequestBodyImpl instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'permitType': instance.permitType,
  'reason': instance.reason,
};
