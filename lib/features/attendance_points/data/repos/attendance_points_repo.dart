import 'package:check_point_v2/core/network/api_result.dart';
import '../models/points_summary_model.dart';
import '../models/points_history_model.dart';
import '../models/points_exchange_model.dart';
import '../models/points_badge_model.dart';
import '../models/points_leaderboard_model.dart';
import '../models/admin_points_employee_model.dart';

abstract class AttendancePointsRepo {
  Future<ApiResult<PointsSummaryModel>> getPointsSummary({String? employeeId});

  Future<ApiResult<List<PointsHistoryItemModel>>> getPointsHistory({
    String? employeeId,
    String? type,
    String? status,
    int page = 1,
    int limit = 30,
  });

  Future<ApiResult<PointsExchangeResultModel>> exchangePoints(
    PointsExchangeRequestBody body,
  );

  Future<ApiResult<List<PointsBadgeItemModel>>> getBadges({String? employeeId});

  Future<ApiResult<List<PointsLeaderboardEntryModel>>> getLeaderboard({
    String scope = 'company',
  });

  Future<ApiResult<AdminPointsEmployeesPageModel>> getAdminPointsEmployees({
    String? departmentId,
    String? search,
    int page = 1,
    int limit = 50,
  });
}
