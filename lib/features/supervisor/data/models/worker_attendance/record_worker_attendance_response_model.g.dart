// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_worker_attendance_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordWorkerAttendanceResponseModel
_$RecordWorkerAttendanceResponseModelFromJson(Map<String, dynamic> json) =>
    RecordWorkerAttendanceResponseModel(
      value: json['value'] == null
          ? null
          : RecordWorkerAttendanceValueModel.fromJson(
              json['value'] as Map<String, dynamic>,
            ),
      isSuccess: json['isSuccess'] as bool?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      message: json['message'] as String?,
    );

RecordWorkerAttendanceValueModel _$RecordWorkerAttendanceValueModelFromJson(
  Map<String, dynamic> json,
) => RecordWorkerAttendanceValueModel(
  submitted: (json['submitted'] as num?)?.toInt(),
  succeeded: (json['succeeded'] as num?)?.toInt(),
  failed: (json['failed'] as num?)?.toInt(),
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => WorkerRecordResultModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

WorkerRecordResultModel _$WorkerRecordResultModelFromJson(
  Map<String, dynamic> json,
) => WorkerRecordResultModel(
  workerId: json['workerId'] as String,
  workerName: json['workerName'] as String?,
  outcome: json['outcome'] as String,
  otherSiteName: json['otherSiteName'] as String?,
  attendanceId: json['attendanceId'] as String?,
);
