import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/points_summary_model.dart';
import '../../data/models/points_history_model.dart';
import '../../data/models/points_badge_model.dart';
import '../../data/models/points_leaderboard_model.dart';
import '../../data/repos/attendance_points_repo.dart';
import 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit({required this.pointsRepo}) : super(const PointsState.initial());

  final AttendancePointsRepo pointsRepo;

  PointsSummaryModel? currentSummary;
  List<PointsHistoryItemModel> currentHistory = [];
  List<PointsBadgeItemModel> currentBadges = [];
  List<PointsLeaderboardEntryModel> currentLeaderboard = [];

  Future<void> loadAllPointsData({String? employeeId}) async {
    emit(const PointsState.loading());
    final summaryResult = await pointsRepo.getPointsSummary(employeeId: employeeId);

    summaryResult.when(
      success: (summary) async {
        currentSummary = summary;
        final historyResult = await pointsRepo.getPointsHistory(employeeId: employeeId);
        final badgesResult = await pointsRepo.getBadges(employeeId: employeeId);
        final leaderboardResult = await pointsRepo.getLeaderboard();

        currentHistory = historyResult.when(success: (d) => d, failure: (_) => []);
        currentBadges = badgesResult.when(success: (d) => d, failure: (_) => []);
        currentLeaderboard = leaderboardResult.when(success: (d) => d, failure: (_) => []);

        emit(
          PointsState.loaded(
            summary: summary,
            history: currentHistory,
            badges: currentBadges,
            leaderboard: currentLeaderboard,
          ),
        );
      },
      failure: (failure) {
        emit(PointsState.error(failure.messageKey));
      },
    );
  }

  Future<void> refreshSummary({String? employeeId}) async {
    final summaryResult = await pointsRepo.getPointsSummary(employeeId: employeeId);
    summaryResult.when(
      success: (summary) {
        currentSummary = summary;
        emit(
          PointsState.loaded(
            summary: summary,
            history: currentHistory,
            badges: currentBadges,
            leaderboard: currentLeaderboard,
          ),
        );
      },
      failure: (_) {},
    );
  }
}
