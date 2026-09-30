// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendancePointModelImpl _$$AttendancePointModelImplFromJson(
  Map<String, dynamic> json,
) => _$AttendancePointModelImpl(
  id: json['id'] as String,
  pointType: json['pointType'] as String,
  status: json['status'] as String,
  source: json['source'] as String,
  points: (json['points'] as num).toInt(),
  attendanceDate: json['attendanceDate'] as String,
  reason: json['reason'] as String,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$AttendancePointModelImplToJson(
  _$AttendancePointModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'pointType': instance.pointType,
  'status': instance.status,
  'source': instance.source,
  'points': instance.points,
  'attendanceDate': instance.attendanceDate,
  'reason': instance.reason,
  'createdAt': instance.createdAt?.toIso8601String(),
};
