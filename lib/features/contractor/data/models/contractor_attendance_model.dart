import 'package:freezed_annotation/freezed_annotation.dart';

part 'contractor_attendance_model.freezed.dart';
part 'contractor_attendance_model.g.dart';

@freezed
abstract class ContractorAttendanceModel with _$ContractorAttendanceModel {
  const factory ContractorAttendanceModel({
    required String id,
    required String workerId,
    required String workerName,
    required String workerCode,
    required String jobTitle,
    required String siteName,
    required String projectName,
    required String date,
    required String status,
    String? checkInTime,
    String? checkOutTime,
    String? workedHours,
    @Default(true) bool isInsideGeofence,
    @Default(false) bool isOfflineSynced,
    String? contractorId,
    String? deviceUuid,
    String? siteId,
    String? projectId,
  }) = _ContractorAttendanceModel;

  factory ContractorAttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$ContractorAttendanceModelFromJson(json);
}
