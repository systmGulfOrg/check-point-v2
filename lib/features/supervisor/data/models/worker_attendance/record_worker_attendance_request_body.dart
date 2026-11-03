import 'package:json_annotation/json_annotation.dart';

part 'record_worker_attendance_request_body.g.dart';

@JsonSerializable()
class WorkerCoordinateModel {
  const WorkerCoordinateModel({
    required this.latitude,
    required this.longitude,
    this.accuracyM,
  });

  final double latitude;
  final double longitude;
  final double? accuracyM;

  factory WorkerCoordinateModel.fromJson(Map<String, dynamic> json) =>
      _$WorkerCoordinateModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerCoordinateModelToJson(this);
}

@JsonSerializable()
class RecordWorkerAttendanceRequestBody {
  const RecordWorkerAttendanceRequestBody({
    required this.siteId,
    required this.date,
    required this.workerIds,
    required this.clockIn,
    this.clockOut,
    this.note,
    this.coordinates = const [],
  });

  final String siteId;
  final String date;
  final List<String> workerIds;
  final String clockIn;
  final String? clockOut;
  final String? note;
  final List<WorkerCoordinateModel> coordinates;

  factory RecordWorkerAttendanceRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$RecordWorkerAttendanceRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RecordWorkerAttendanceRequestBodyToJson(this);
}
