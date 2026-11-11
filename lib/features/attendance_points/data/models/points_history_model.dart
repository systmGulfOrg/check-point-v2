import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_history_model.freezed.dart';
part 'points_history_model.g.dart';

@freezed
class PointsHistoryItemModel with _$PointsHistoryItemModel {
  const PointsHistoryItemModel._();

  const factory PointsHistoryItemModel({
    required String id,
    required String pointType,
    required String status,
    required String source,
    @Default(0) int points,
    required String attendanceDate,
    required String reason,
    String? cancelReason,
    String? permissionId,
    String? attendanceId,
    String? expiresAt,
    String? recomputedAt,
    Map<String, dynamic>? computationSnapshot,
    required String createdAt,
  }) = _PointsHistoryItemModel;

  factory PointsHistoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$PointsHistoryItemModelFromJson(json);

  /// Localization key for why the engine cancelled this point (leave,
  /// holiday, weekly day off, permit...), or null when there is none.
  String? get cancelReasonKey => switch (cancelReason) {
    'Official Holiday' => 'points.cancelReason.holiday',
    'Approved full-day leave' => 'points.cancelReason.leave',
    'Weekly day off' || 'Non-working day' => 'points.cancelReason.weeklyOff',
    'Approved permit' || 'permission_approved' || 'conflict_with_permission' =>
      'points.cancelReason.permit',
    'Day not finished' => 'points.cancelReason.dayNotFinished',
    'Superseded attendance record' => 'points.cancelReason.attendanceEdited',
    null || '' => null,
    _ => 'points.cancelReason.other',
  };
}

@freezed
class PointsHistoryPageModel with _$PointsHistoryPageModel {
  const factory PointsHistoryPageModel({
    @Default(<PointsHistoryItemModel>[]) List<PointsHistoryItemModel> items,
    int? totalCount,
    int? index,
    int? itemCount,
    int? totalPages,
    bool? hasNext,
    bool? hasPrevious,
  }) = _PointsHistoryPageModel;

  factory PointsHistoryPageModel.fromJson(Map<String, dynamic> json) =>
      _$PointsHistoryPageModelFromJson(json);
}

@freezed
class PointsHistoryResponseModel with _$PointsHistoryResponseModel {
  const factory PointsHistoryResponseModel({
    PointsHistoryPageModel? value,
    int? total,
    int? page,
    int? limit,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  }) = _PointsHistoryResponseModel;

  factory PointsHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PointsHistoryResponseModelFromJson(json);
}
