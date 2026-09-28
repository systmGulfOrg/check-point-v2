// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_correction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorCorrectionModelImpl _$$ContractorCorrectionModelImplFromJson(
  Map<String, dynamic> json,
) => _$ContractorCorrectionModelImpl(
  id: json['id'] as String,
  workerId: json['workerId'] as String,
  workerName: json['workerName'] as String,
  workerCode: json['workerCode'] as String,
  date: json['date'] as String,
  requestedCheckIn: json['requestedCheckIn'] as String,
  requestedCheckOut: json['requestedCheckOut'] as String,
  reason: json['reason'] as String,
  status: json['status'] as String,
  createdAt: json['createdAt'] as String,
  supervisorNotes: json['supervisorNotes'] as String?,
  approvedById: json['approvedById'] as String?,
  approvedAt: json['approvedAt'] as String?,
);

Map<String, dynamic> _$$ContractorCorrectionModelImplToJson(
  _$ContractorCorrectionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'workerId': instance.workerId,
  'workerName': instance.workerName,
  'workerCode': instance.workerCode,
  'date': instance.date,
  'requestedCheckIn': instance.requestedCheckIn,
  'requestedCheckOut': instance.requestedCheckOut,
  'reason': instance.reason,
  'status': instance.status,
  'createdAt': instance.createdAt,
  'supervisorNotes': instance.supervisorNotes,
  'approvedById': instance.approvedById,
  'approvedAt': instance.approvedAt,
};
