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
  leaveTypeName: json['leaveTypeName'] as String?,
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
  directManagerId: json['directManagerId'] as String?,
  directManagerName: json['directManagerName'] as String?,
  hasDirectManager: json['hasDirectManager'] as bool?,
  rejectionReason: json['rejectionReason'] as String?,
  timeline: json['timeline'] as Map<String, dynamic>?,
  managerId: json['managerId'] as String?,
  managerName: json['managerName'] as String?,
  managerActionAt: json['managerActionAt'] == null
      ? null
      : DateTime.parse(json['managerActionAt'] as String),
  managerRejectionReason: json['managerRejectionReason'] as String?,
  hrId: json['hrId'] as String?,
  hrName: json['hrName'] as String?,
  hrActionAt: json['hrActionAt'] == null
      ? null
      : DateTime.parse(json['hrActionAt'] as String),
  hrRejectionReason: json['hrRejectionReason'] as String?,
);

Map<String, dynamic> _$$LeaveRequestModelImplToJson(
  _$LeaveRequestModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'leaveTypeId': instance.leaveTypeId,
  'leaveTypeName': instance.leaveTypeName,
  'employeeId': instance.employeeId,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'totalDays': instance.totalDays,
  'status': instance.status,
  'reason': instance.reason,
  'attachmentUrl': instance.attachmentUrl,
  'createdAt': instance.createdAt?.toIso8601String(),
  'directManagerId': instance.directManagerId,
  'directManagerName': instance.directManagerName,
  'hasDirectManager': instance.hasDirectManager,
  'rejectionReason': instance.rejectionReason,
  'timeline': instance.timeline,
  'managerId': instance.managerId,
  'managerName': instance.managerName,
  'managerActionAt': instance.managerActionAt?.toIso8601String(),
  'managerRejectionReason': instance.managerRejectionReason,
  'hrId': instance.hrId,
  'hrName': instance.hrName,
  'hrActionAt': instance.hrActionAt?.toIso8601String(),
  'hrRejectionReason': instance.hrRejectionReason,
};
