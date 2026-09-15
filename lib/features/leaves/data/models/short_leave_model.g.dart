// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShortLeaveModelImpl _$$ShortLeaveModelImplFromJson(
  Map<String, dynamic> json,
) => _$ShortLeaveModelImpl(
  id: json['id'] as String,
  employeeId: json['employeeId'] as String,
  date: DateTime.parse(json['date'] as String),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  totalHours: (json['totalHours'] as num).toDouble(),
  status: json['status'] as String,
  reason: json['reason'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$ShortLeaveModelImplToJson(
  _$ShortLeaveModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'date': instance.date.toIso8601String(),
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'totalHours': instance.totalHours,
  'status': instance.status,
  'reason': instance.reason,
  'createdAt': instance.createdAt?.toIso8601String(),
};
