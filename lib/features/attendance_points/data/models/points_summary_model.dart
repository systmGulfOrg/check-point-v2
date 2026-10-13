import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_summary_model.freezed.dart';
part 'points_summary_model.g.dart';

@freezed
class PointsBalancesModel with _$PointsBalancesModel {
  const factory PointsBalancesModel({
    @Default(0) int greenConfirmed,
    @Default(0) int greenPending,
    @Default(0) int red,
    @Default(0) int black,
    @Default(0) int expiringSoonGreen,
  }) = _PointsBalancesModel;

  factory PointsBalancesModel.fromJson(Map<String, dynamic> json) =>
      _$PointsBalancesModelFromJson(json);
}

@freezed
class PointsLevelModel with _$PointsLevelModel {
  const factory PointsLevelModel({
    @Default('Bronze') String tier,
    @Default(0) int currentPoints,
    @Default(101) int nextLevelPoints,
    @Default(0.0) double progress,
  }) = _PointsLevelModel;

  factory PointsLevelModel.fromJson(Map<String, dynamic> json) =>
      _$PointsLevelModelFromJson(json);
}

@freezed
class PointsStreakModel with _$PointsStreakModel {
  const factory PointsStreakModel({
    @Default(0) int currentStreak,
    @Default(0) int highestStreak,
  }) = _PointsStreakModel;

  factory PointsStreakModel.fromJson(Map<String, dynamic> json) =>
      _$PointsStreakModelFromJson(json);
}

@freezed
class PointsSettingsModel with _$PointsSettingsModel {
  const factory PointsSettingsModel({
    @Default(1) int redExchangeRate,
    @Default(30) int blackExchangeCost,
    @Default(false) bool tieredRateEnabled,
    @Default(10) int graceMinutes,
  }) = _PointsSettingsModel;

  factory PointsSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$PointsSettingsModelFromJson(json);
}

@freezed
class PointsSummaryModel with _$PointsSummaryModel {
  const factory PointsSummaryModel({
    String? employeeId,
    @Default(PointsBalancesModel()) PointsBalancesModel balances,
    @Default(PointsLevelModel()) PointsLevelModel level,
    @Default(PointsStreakModel()) PointsStreakModel streak,
    @Default(PointsSettingsModel()) PointsSettingsModel settings,
  }) = _PointsSummaryModel;

  factory PointsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$PointsSummaryModelFromJson(json);
}

@freezed
class PointsSummaryResponseModel with _$PointsSummaryResponseModel {
  const factory PointsSummaryResponseModel({
    PointsSummaryModel? value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  }) = _PointsSummaryResponseModel;

  factory PointsSummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PointsSummaryResponseModelFromJson(json);
}
