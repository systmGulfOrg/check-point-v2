import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/admin_attendance_model.dart';

part 'admin_attendance_state.freezed.dart';

@freezed
abstract class AdminAttendanceState with _$AdminAttendanceState {
  const factory AdminAttendanceState.initial() = _Initial;
  const factory AdminAttendanceState.loading() = _Loading;
  const factory AdminAttendanceState.success(
    List<AdminAttendanceModel> records,
  ) = _Success;
  const factory AdminAttendanceState.actionSuccess(String message) =
      _ActionSuccess;
  const factory AdminAttendanceState.error(String messageKey) = _Error;
}
