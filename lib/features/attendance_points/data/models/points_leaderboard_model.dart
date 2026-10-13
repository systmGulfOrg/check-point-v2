import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_leaderboard_model.freezed.dart';
part 'points_leaderboard_model.g.dart';

@freezed
class PointsLeaderboardEntryModel with _$PointsLeaderboardEntryModel {
  const PointsLeaderboardEntryModel._();

  const factory PointsLeaderboardEntryModel({
    required int rank,
    required String employeeId,
    required String name,
    String? avatar,
    String? position,
    String? departmentName,
    @Default(0) int points,
    int? netPoints,
    int? greenPoints,
    int? redPoints,
    @Default(0) int currentStreak,
    @Default('Bronze') String level,
    @Default(false) bool isCurrentUser,
  }) = _PointsLeaderboardEntryModel;

  int get effectivePoints => netPoints ?? points;

  factory PointsLeaderboardEntryModel.fromJson(Map<String, dynamic> json) =>
      _$PointsLeaderboardEntryModelFromJson(json);
}

@freezed
class PointsLeaderboardResponseModel with _$PointsLeaderboardResponseModel {
  const factory PointsLeaderboardResponseModel({
    @Default(<PointsLeaderboardEntryModel>[]) List<PointsLeaderboardEntryModel> value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  }) = _PointsLeaderboardResponseModel;

  factory PointsLeaderboardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PointsLeaderboardResponseModelFromJson(json);
}
