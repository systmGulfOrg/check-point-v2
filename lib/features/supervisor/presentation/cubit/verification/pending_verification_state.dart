import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/core/models/offline_attendance_models.dart';

part 'pending_verification_state.freezed.dart';

@freezed
class PendingVerificationState with _$PendingVerificationState {
  const factory PendingVerificationState.initial() = _Initial;
  const factory PendingVerificationState.loading() = _Loading;
  const factory PendingVerificationState.loaded(List<PendingAttendanceItem> items) = _Loaded;
  const factory PendingVerificationState.error(String messageKey) = _Error;
  const factory PendingVerificationState.actionSuccess(String messageKey) = _ActionSuccess;
}
