import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/features/attendance_points/data/models/attendance_point_model.dart';
import 'package:check_point_v2/features/attendance_points/data/models/points_summary_model.dart';
import 'package:check_point_v2/features/attendance_points/data/repos/attendance_points_repo.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/attendance_points_cubit.dart';
import 'package:check_point_v2/features/attendance_points/presentation/cubit/attendance_points_state.dart';

class FakeAttendancePointsRepo implements AttendancePointsRepo {
  FakeAttendancePointsRepo({this.fail = false});
  final bool fail;

  @override
  Future<ApiResult<PointsSummaryModel>> getSummary({String? employeeId}) async {
    if (fail) {
      return const ApiResult.failure(ApiFailure(messageKey: 'points.failure'));
    }
    return const ApiResult.success(
      PointsSummaryModel(green: 3, red: 1, black: 0),
    );
  }

  @override
  Future<ApiResult<List<AttendancePointModel>>> getHistory({
    String? employeeId,
  }) async {
    if (fail) {
      return const ApiResult.failure(ApiFailure(messageKey: 'points.failure'));
    }
    return const ApiResult.success(<AttendancePointModel>[]);
  }

  @override
  Future<ApiResult<List<Map<String, dynamic>>>> getMonthlySummary({
    required int year,
    required int month,
    String? employeeId,
  }) async => const ApiResult.success(<Map<String, dynamic>>[]);
}

void main() {
  blocTest<AttendancePointsCubit, AttendancePointsState>(
    'loads summary and history successfully',
    build: () => AttendancePointsCubit(repo: FakeAttendancePointsRepo()),
    act: (cubit) => cubit.load(),
    expect: () => [
      const AttendancePointsState.loading(),
      const AttendancePointsState.success(
        summary: PointsSummaryModel(green: 3, red: 1, black: 0),
        history: [],
      ),
    ],
  );

  blocTest<AttendancePointsCubit, AttendancePointsState>(
    'maps repository failure to an error state',
    build: () =>
        AttendancePointsCubit(repo: FakeAttendancePointsRepo(fail: true)),
    act: (cubit) => cubit.load(),
    expect: () => [
      const AttendancePointsState.loading(),
      const AttendancePointsState.error('points.failure'),
    ],
  );
}
