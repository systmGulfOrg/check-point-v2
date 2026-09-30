import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_point_model.freezed.dart';
part 'attendance_point_model.g.dart';

@freezed
class AttendancePointModel with _$AttendancePointModel {
  const factory AttendancePointModel({
    required String id,
    required String pointType,
    required String status,
    required String source,
    required int points,
    required String attendanceDate,
    required String reason,
    DateTime? createdAt,
  }) = _AttendancePointModel;

  factory AttendancePointModel.fromJson(Map<String, dynamic> json) =>
      _$AttendancePointModelFromJson(json);
}
