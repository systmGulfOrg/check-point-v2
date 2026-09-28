// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorAttendanceModelImpl _$$ContractorAttendanceModelImplFromJson(
  Map<String, dynamic> json,
) => _$ContractorAttendanceModelImpl(
  id: json['id'] as String,
  workerId: json['workerId'] as String,
  workerName: json['workerName'] as String,
  workerCode: json['workerCode'] as String,
  jobTitle: json['jobTitle'] as String,
  siteName: json['siteName'] as String,
  projectName: json['projectName'] as String,
  date: json['date'] as String,
  status: json['status'] as String,
  checkInTime: json['checkInTime'] as String?,
  checkOutTime: json['checkOutTime'] as String?,
  workedHours: json['workedHours'] as String?,
  isInsideGeofence: json['isInsideGeofence'] as bool? ?? true,
  isOfflineSynced: json['isOfflineSynced'] as bool? ?? false,
  contractorId: json['contractorId'] as String?,
  deviceUuid: json['deviceUuid'] as String?,
  siteId: json['siteId'] as String?,
  projectId: json['projectId'] as String?,
);

Map<String, dynamic> _$$ContractorAttendanceModelImplToJson(
  _$ContractorAttendanceModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'workerId': instance.workerId,
  'workerName': instance.workerName,
  'workerCode': instance.workerCode,
  'jobTitle': instance.jobTitle,
  'siteName': instance.siteName,
  'projectName': instance.projectName,
  'date': instance.date,
  'status': instance.status,
  'checkInTime': instance.checkInTime,
  'checkOutTime': instance.checkOutTime,
  'workedHours': instance.workedHours,
  'isInsideGeofence': instance.isInsideGeofence,
  'isOfflineSynced': instance.isOfflineSynced,
  'contractorId': instance.contractorId,
  'deviceUuid': instance.deviceUuid,
  'siteId': instance.siteId,
  'projectId': instance.projectId,
};
