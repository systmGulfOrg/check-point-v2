import 'package:json_annotation/json_annotation.dart';

part 'record_worker_attendance_response_model.g.dart';

@JsonSerializable(createToJson: false)
class RecordWorkerAttendanceResponseModel {
  const RecordWorkerAttendanceResponseModel({
    this.value,
    this.isSuccess,
    this.errors,
    this.message,
  });

  final RecordWorkerAttendanceValueModel? value;
  final bool? isSuccess;
  final List<String>? errors;
  final String? message;

  factory RecordWorkerAttendanceResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$RecordWorkerAttendanceResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class RecordWorkerAttendanceValueModel {
  const RecordWorkerAttendanceValueModel({
    this.submitted,
    this.succeeded,
    this.failed,
    this.results,
  });

  final int? submitted;
  final int? succeeded;
  final int? failed;
  final List<WorkerRecordResultModel>? results;

  factory RecordWorkerAttendanceValueModel.fromJson(
    Map<String, dynamic> json,
  ) => _$RecordWorkerAttendanceValueModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class WorkerRecordResultModel {
  const WorkerRecordResultModel({
    required this.workerId,
    this.workerName,
    required this.outcome,
    this.otherSiteName,
    this.attendanceId,
  });

  final String workerId;
  final String? workerName;
  final String outcome;
  final String? otherSiteName;
  final String? attendanceId;

  factory WorkerRecordResultModel.fromJson(Map<String, dynamic> json) =>
      _$WorkerRecordResultModelFromJson(json);
}
