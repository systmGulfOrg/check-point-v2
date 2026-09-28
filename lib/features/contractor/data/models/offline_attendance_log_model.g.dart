// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_attendance_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfflineAttendanceLogModelImpl _$$OfflineAttendanceLogModelImplFromJson(
  Map<String, dynamic> json,
) => _$OfflineAttendanceLogModelImpl(
  localId: json['localId'] as String,
  workerId: json['workerId'] as String,
  punchType: json['punchType'] as String,
  timestamp: json['timestamp'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  siteId: json['siteId'] as String,
  projectId: json['projectId'] as String?,
  contractorId: json['contractorId'] as String?,
  deviceUuid: json['deviceUuid'] as String?,
  isInsideGeofence: json['isInsideGeofence'] as bool? ?? true,
  isSynced: json['isSynced'] as bool? ?? false,
  syncError: json['syncError'] as String?,
);

Map<String, dynamic> _$$OfflineAttendanceLogModelImplToJson(
  _$OfflineAttendanceLogModelImpl instance,
) => <String, dynamic>{
  'localId': instance.localId,
  'workerId': instance.workerId,
  'punchType': instance.punchType,
  'timestamp': instance.timestamp,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'siteId': instance.siteId,
  'projectId': instance.projectId,
  'contractorId': instance.contractorId,
  'deviceUuid': instance.deviceUuid,
  'isInsideGeofence': instance.isInsideGeofence,
  'isSynced': instance.isSynced,
  'syncError': instance.syncError,
};
