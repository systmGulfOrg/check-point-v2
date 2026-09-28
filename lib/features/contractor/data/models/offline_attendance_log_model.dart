import 'package:freezed_annotation/freezed_annotation.dart';

part 'offline_attendance_log_model.freezed.dart';
part 'offline_attendance_log_model.g.dart';

@freezed
abstract class OfflineAttendanceLogModel with _$OfflineAttendanceLogModel {
  const factory OfflineAttendanceLogModel({
    required String localId,
    required String workerId,
    required String punchType,
    required String timestamp,
    required double latitude,
    required double longitude,
    required String siteId,
    String? projectId,
    String? contractorId,
    String? deviceUuid,
    @Default(true) bool isInsideGeofence,
    @Default(false) bool isSynced,
    String? syncError,
  }) = _OfflineAttendanceLogModel;

  factory OfflineAttendanceLogModel.fromJson(Map<String, dynamic> json) =>
      _$OfflineAttendanceLogModelFromJson(json);
}
