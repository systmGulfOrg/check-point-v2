import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/attendance_point_model.dart';
import '../../data/models/points_summary_model.dart';

part 'attendance_points_state.freezed.dart';

@freezed
class AttendancePointsState with _$AttendancePointsState {
  const factory AttendancePointsState.initial() = AttendancePointsInitial;
  const factory AttendancePointsState.loading() = AttendancePointsLoading;
  const factory AttendancePointsState.success({
    required PointsSummaryModel summary,
    required List<AttendancePointModel> history,
  }) = AttendancePointsSuccess;
  const factory AttendancePointsState.error(String messageKey) =
      AttendancePointsError;
}
