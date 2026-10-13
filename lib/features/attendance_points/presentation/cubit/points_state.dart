import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/points_summary_model.dart';
import '../../data/models/points_history_model.dart';
import '../../data/models/points_badge_model.dart';
import '../../data/models/points_leaderboard_model.dart';

part 'points_state.freezed.dart';

@freezed
class PointsState with _$PointsState {
  const factory PointsState.initial() = PointsInitial;
  const factory PointsState.loading() = PointsLoading;
  const factory PointsState.loaded({
    required PointsSummaryModel summary,
    @Default(<PointsHistoryItemModel>[]) List<PointsHistoryItemModel> history,
    @Default(<PointsBadgeItemModel>[]) List<PointsBadgeItemModel> badges,
    @Default(<PointsLeaderboardEntryModel>[]) List<PointsLeaderboardEntryModel> leaderboard,
  }) = PointsLoaded;
  const factory PointsState.error(String message) = PointsError;
}
