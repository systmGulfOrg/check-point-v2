// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_worker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorWorkerModelImpl _$$ContractorWorkerModelImplFromJson(
  Map<String, dynamic> json,
) => _$ContractorWorkerModelImpl(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  workerCode: json['workerCode'] as String,
  nationalId: json['nationalId'] as String,
  phone: json['phone'] as String,
  jobTitle: json['jobTitle'] as String,
  projectName: json['projectName'] as String,
  siteName: json['siteName'] as String,
  status: json['status'] as String? ?? 'active',
  startDate: json['startDate'] as String? ?? '',
  photoUrl: json['photoUrl'] as String?,
  lastCheckIn: json['lastCheckIn'] as String?,
  contractorId: json['contractorId'] as String?,
  contractorName: json['contractorName'] as String?,
  deviceUuid: json['deviceUuid'] as String?,
);

Map<String, dynamic> _$$ContractorWorkerModelImplToJson(
  _$ContractorWorkerModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'workerCode': instance.workerCode,
  'nationalId': instance.nationalId,
  'phone': instance.phone,
  'jobTitle': instance.jobTitle,
  'projectName': instance.projectName,
  'siteName': instance.siteName,
  'status': instance.status,
  'startDate': instance.startDate,
  'photoUrl': instance.photoUrl,
  'lastCheckIn': instance.lastCheckIn,
  'contractorId': instance.contractorId,
  'contractorName': instance.contractorName,
  'deviceUuid': instance.deviceUuid,
};
