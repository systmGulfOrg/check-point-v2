import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../apis/attendance_points_api_service.dart';
import '../models/points_summary_model.dart';
import '../models/points_history_model.dart';
import '../models/points_exchange_model.dart';
import '../models/points_badge_model.dart';
import '../models/points_leaderboard_model.dart';
import '../models/admin_points_employee_model.dart';
import 'attendance_points_repo.dart';

class AttendancePointsRepoImpl implements AttendancePointsRepo {
  AttendancePointsRepoImpl({required this.api});

  final AttendancePointsApiService api;

  @override
  Future<ApiResult<PointsSummaryModel>> getPointsSummary({
    String? employeeId,
  }) async {
    try {
      final response = await api.getPointsSummary(employeeId: employeeId);
      final model = response.value ?? const PointsSummaryModel();
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<PointsHistoryItemModel>>> getPointsHistory({
    String? employeeId,
    String? type,
    String? status,
    int page = 1,
    int limit = 30,
  }) async {
    try {
      final response = await api.getPointsHistory(
        employeeId: employeeId,
        type: type,
        status: status,
        page: page,
        limit: limit,
      );
      return ApiResult.success(response.value?.items ?? const []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<PointsExchangeResultModel>> exchangePoints(
    PointsExchangeRequestBody body,
  ) async {
    try {
      final response = await api.exchangePoints(body.toJson());
      if (response.value != null) {
        return ApiResult.success(response.value!);
      }
      return ApiResult.failure(
        ApiFailureMapper.fromMessages(
          response.errors,
          fallbackMessageKey: 'points.exchangeFailed',
        ),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<PointsBadgeItemModel>>> getBadges({
    String? employeeId,
  }) async {
    try {
      final response = await api.getBadges(employeeId: employeeId);
      return ApiResult.success(response.value);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<PointsLeaderboardEntryModel>>> getLeaderboard({
    String scope = 'company',
  }) async {
    try {
      final response = await api.getLeaderboard(scope: scope);
      return ApiResult.success(response.value);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<AdminPointsEmployeesPageModel>> getAdminPointsEmployees({
    String? departmentId,
    String? search,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await api.getAdminPointsEmployees(
        departmentId: departmentId,
        search: search?.trim().isEmpty == true ? null : search?.trim(),
        page: page,
        limit: limit,
      );
      return ApiResult.success(
        response.value ?? const AdminPointsEmployeesPageModel(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
