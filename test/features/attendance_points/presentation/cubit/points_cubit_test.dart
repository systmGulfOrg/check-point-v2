import 'dart:async';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/features/attendance_points/data/models/points_summary_model.dart';
import 'package:check_point_v2/features/attendance_points/data/models/points_badge_model.dart';
import 'package:check_point_v2/features/attendance_points/data/models/points_history_model.dart';
import 'package:check_point_v2/features/attendance_points/data/models/points_leaderboard_model.dart';
import 'package:check_point_v2/features/attendance_points/data/models/points_exchange_model.dart';
import 'package:check_point_v2/features/attendance_points/data/models/admin_points_employee_model.dart';
import 'package:check_point_v2/features/attendance_points/data/repos/attendance_points_repo.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/points_cubit.dart';

class _FakeAttendancePointsRepo implements AttendancePointsRepo {
  _FakeAttendancePointsRepo(this.summaryFuture);

  final Future<ApiResult<PointsSummaryModel>> summaryFuture;

  @override
  Future<ApiResult<PointsSummaryModel>> getPointsSummary({
    String? employeeId,
  }) => summaryFuture;

  @override
  Future<ApiResult<List<PointsHistoryItemModel>>> getPointsHistory({
    String? employeeId,
    String? type,
    String? status,
    int page = 1,
    int limit = 30,
  }) => throw UnimplementedError();

  @override
  Future<ApiResult<PointsExchangeResultModel>> exchangePoints(
    PointsExchangeRequestBody body,
  ) => throw UnimplementedError();

  @override
  Future<ApiResult<List<PointsBadgeItemModel>>> getBadges({
    String? employeeId,
  }) => throw UnimplementedError();

  @override
  Future<ApiResult<List<PointsLeaderboardEntryModel>>> getLeaderboard({
    String scope = 'company',
  }) => throw UnimplementedError();

  @override
  Future<ApiResult<AdminPointsEmployeesPageModel>> getAdminPointsEmployees({
    String? departmentId,
    String? search,
    int page = 1,
    int limit = 50,
  }) => throw UnimplementedError();
}

void main() {
  test('does not emit after it is closed while loading points', () async {
    final summaryCompleter = Completer<ApiResult<PointsSummaryModel>>();
    final repo = _FakeAttendancePointsRepo(summaryCompleter.future);

    final cubit = PointsCubit(pointsRepo: repo);
    final loadFuture = cubit.loadAllPointsData();
    await Future<void>.delayed(Duration.zero);
    await cubit.close();

    summaryCompleter.complete(const ApiResult.success(PointsSummaryModel()));
    await loadFuture;
  });
}
