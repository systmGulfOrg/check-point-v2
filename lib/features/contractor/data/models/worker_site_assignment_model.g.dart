// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_site_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkerSiteAssignmentModelImpl _$$WorkerSiteAssignmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$WorkerSiteAssignmentModelImpl(
  id: json['id'] as String,
  workerId: json['workerId'] as String,
  workerName: json['workerName'] as String,
  branchId: json['branchId'] as String,
  siteName: json['siteName'] as String,
  assignedById: json['assignedById'] as String?,
  assignedByName: json['assignedByName'] as String?,
  validFrom: json['validFrom'] as String?,
  validUntil: json['validUntil'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  contractorId: json['contractorId'] as String?,
  contractorName: json['contractorName'] as String?,
  projectId: json['projectId'] as String?,
  projectName: json['projectName'] as String?,
);

Map<String, dynamic> _$$WorkerSiteAssignmentModelImplToJson(
  _$WorkerSiteAssignmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'workerId': instance.workerId,
  'workerName': instance.workerName,
  'branchId': instance.branchId,
  'siteName': instance.siteName,
  'assignedById': instance.assignedById,
  'assignedByName': instance.assignedByName,
  'validFrom': instance.validFrom,
  'validUntil': instance.validUntil,
  'isActive': instance.isActive,
  'contractorId': instance.contractorId,
  'contractorName': instance.contractorName,
  'projectId': instance.projectId,
  'projectName': instance.projectName,
};
