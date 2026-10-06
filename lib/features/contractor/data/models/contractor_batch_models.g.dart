// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_batch_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorDailyAttendanceRequestBodyImpl
_$$ContractorDailyAttendanceRequestBodyImplFromJson(
  Map<String, dynamic> json,
) => _$ContractorDailyAttendanceRequestBodyImpl(
  contractorId: json['contractor_id'] as String,
  siteId: json['site_id'] as String,
  date: json['date'] as String,
  status: json['status'] as String? ?? 'Present',
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$ContractorDailyAttendanceRequestBodyImplToJson(
  _$ContractorDailyAttendanceRequestBodyImpl instance,
) => <String, dynamic>{
  'contractor_id': instance.contractorId,
  'site_id': instance.siteId,
  'date': instance.date,
  'status': instance.status,
  'notes': instance.notes,
};

_$BatchWorkerAttendanceRequestBodyImpl
_$$BatchWorkerAttendanceRequestBodyImplFromJson(Map<String, dynamic> json) =>
    _$BatchWorkerAttendanceRequestBodyImpl(
      siteId: json['site_id'] as String,
      contractorId: json['contractor_id'] as String,
      date: json['date'] as String,
      workerIds: (json['worker_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$BatchWorkerAttendanceRequestBodyImplToJson(
  _$BatchWorkerAttendanceRequestBodyImpl instance,
) => <String, dynamic>{
  'site_id': instance.siteId,
  'contractor_id': instance.contractorId,
  'date': instance.date,
  'worker_ids': instance.workerIds,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

_$SingleWorkerBatchResultModelImpl _$$SingleWorkerBatchResultModelImplFromJson(
  Map<String, dynamic> json,
) => _$SingleWorkerBatchResultModelImpl(
  workerId: json['workerId'] as String,
  workerName: json['workerName'] as String?,
  status: json['status'] as String,
  errorCode: json['errorCode'] as String?,
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$$SingleWorkerBatchResultModelImplToJson(
  _$SingleWorkerBatchResultModelImpl instance,
) => <String, dynamic>{
  'workerId': instance.workerId,
  'workerName': instance.workerName,
  'status': instance.status,
  'errorCode': instance.errorCode,
  'errorMessage': instance.errorMessage,
};

_$BatchWorkerAttendanceSummaryModelImpl
_$$BatchWorkerAttendanceSummaryModelImplFromJson(Map<String, dynamic> json) =>
    _$BatchWorkerAttendanceSummaryModelImpl(
      totalSubmitted: (json['totalSubmitted'] as num?)?.toInt() ?? 0,
      successfulCount: (json['successfulCount'] as num?)?.toInt() ?? 0,
      failedCount: (json['failedCount'] as num?)?.toInt() ?? 0,
      results:
          (json['results'] as List<dynamic>?)
              ?.map(
                (e) => SingleWorkerBatchResultModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BatchWorkerAttendanceSummaryModelImplToJson(
  _$BatchWorkerAttendanceSummaryModelImpl instance,
) => <String, dynamic>{
  'totalSubmitted': instance.totalSubmitted,
  'successfulCount': instance.successfulCount,
  'failedCount': instance.failedCount,
  'results': instance.results,
};

_$BatchWorkerAttendanceResponseModelImpl
_$$BatchWorkerAttendanceResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$BatchWorkerAttendanceResponseModelImpl(
      isSuccess: json['isSuccess'] as bool? ?? false,
      status: (json['status'] as num?)?.toInt(),
      value: json['value'] == null
          ? null
          : BatchWorkerAttendanceSummaryModel.fromJson(
              json['value'] as Map<String, dynamic>,
            ),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$BatchWorkerAttendanceResponseModelImplToJson(
  _$BatchWorkerAttendanceResponseModelImpl instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'status': instance.status,
  'value': instance.value,
  'errorMessage': instance.errorMessage,
};

_$NationalIdDetailsModelImpl _$$NationalIdDetailsModelImplFromJson(
  Map<String, dynamic> json,
) => _$NationalIdDetailsModelImpl(
  birthDate: json['birthDate'] as String?,
  gender: json['gender'] as String?,
  governorate: json['governorate'] as String?,
  governorateCode: json['governorateCode'] as String?,
  century: json['century'] as String?,
);

Map<String, dynamic> _$$NationalIdDetailsModelImplToJson(
  _$NationalIdDetailsModelImpl instance,
) => <String, dynamic>{
  'birthDate': instance.birthDate,
  'gender': instance.gender,
  'governorate': instance.governorate,
  'governorateCode': instance.governorateCode,
  'century': instance.century,
};
