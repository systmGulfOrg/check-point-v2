// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveRequestModelImpl _$$LeaveRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$LeaveRequestModelImpl(
  id: json['id'] as String,
  leaveTypeId: json['leaveTypeId'] as String,
  employeeId: json['employeeId'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  totalDays: (json['totalDays'] as num).toInt(),
  status: json['status'] as String,
  reason: json['reason'] as String?,
  attachmentUrl: json['attachmentUrl'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$LeaveRequestModelImplToJson(
  _$LeaveRequestModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'leaveTypeId': instance.leaveTypeId,
  'employeeId': instance.employeeId,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'totalDays': instance.totalDays,
  'status': instance.status,
  'reason': instance.reason,
  'attachmentUrl': instance.attachmentUrl,
  'createdAt': instance.createdAt?.toIso8601String(),
};
