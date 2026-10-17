import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import '../../data/models/points_summary_model.dart';
import '../../data/models/points_history_model.dart';
import '../../data/models/points_badge_model.dart';
import '../../data/models/points_leaderboard_model.dart';
import '../../data/repos/attendance_points_repo.dart';
import 'points_state.dart';

class PointsCubit extends SafeCubit<PointsState> {
  PointsCubit({required this.pointsRepo}) : super(const PointsState.initial());

  final AttendancePointsRepo pointsRepo;

  PointsSummaryModel? currentSummary;
  List<PointsHistoryItemModel> currentHistory = [];
  List<PointsBadgeItemModel> currentBadges = [];
  List<PointsLeaderboardEntryModel> currentLeaderboard = [];

  Future<void> loadAllPointsData({String? employeeId}) async {
    emit(const PointsState.loading());
    final summaryResult = await pointsRepo.getPointsSummary(
      employeeId: employeeId,
    );
    if (isClosed) return;

    summaryResult.when(
      success: (summary) async {
        if (isClosed) return;
        currentSummary = summary;
        final historyResult = await pointsRepo.getPointsHistory(
          employeeId: employeeId,
        );
        final badgesResult = await pointsRepo.getBadges(employeeId: employeeId);
        final leaderboardResult = await pointsRepo.getLeaderboard();
        if (isClosed) return;

        currentHistory = historyResult.when(
          success: (d) => d,
          failure: (_) => [],
        );
        currentBadges = badgesResult.when(
          success: (d) => d,
          failure: (_) => [],
        );
        currentLeaderboard = leaderboardResult.when(
          success: (d) => d,
          failure: (_) => [],
        );

        if (isClosed) return;
        safeEmit(
          PointsState.loaded(
            summary: summary,
            history: currentHistory,
            badges: currentBadges,
            leaderboard: currentLeaderboard,
          ),
        );
      },
      failure: (failure) {
        if (isClosed) return;
        safeEmit(PointsState.error(failure.messageKey));
      },
    );
  }

  Future<void> refreshSummary({String? employeeId}) async {
    if (isClosed) return;
    final summaryResult = await pointsRepo.getPointsSummary(
      employeeId: employeeId,
    );
    if (isClosed) return;
    summaryResult.when(
      success: (summary) {
        if (isClosed) return;
        currentSummary = summary;
        safeEmit(
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
