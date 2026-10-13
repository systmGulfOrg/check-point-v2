import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:check_point_v2/core/network/api_constants.dart';
import '../models/points_summary_model.dart';
import '../models/points_history_model.dart';
import '../models/points_exchange_model.dart';
import '../models/points_badge_model.dart';
import '../models/points_leaderboard_model.dart';

part 'attendance_points_api_service.g.dart';

@RestApi()
abstract class AttendancePointsApiService {
  factory AttendancePointsApiService(Dio dio, {String? baseUrl}) =
      _AttendancePointsApiService;

  @GET(ApiConstants.pointsSummary)
  Future<PointsSummaryResponseModel> getPointsSummary({
    @Query('employeeId') String? employeeId,
  });

  @GET(ApiConstants.pointsHistory)
  Future<PointsHistoryResponseModel> getPointsHistory({
    @Query('employeeId') String? employeeId,
    @Query('type') String? type,
    @Query('status') String? status,
    @Query('page') int page = 1,
    @Query('limit') int limit = 30,
  });

  @POST(ApiConstants.pointsExchange)
  Future<PointsExchangeResponseModel> exchangePoints(
    @Body() PointsExchangeRequestBody body,
  );

  @GET(ApiConstants.pointsBadges)
  Future<PointsBadgesResponseModel> getBadges({
    @Query('employeeId') String? employeeId,
  });

  @GET(ApiConstants.pointsLeaderboard)
  Future<PointsLeaderboardResponseModel> getLeaderboard({
    @Query('scope') String scope = 'company',
  });
}
