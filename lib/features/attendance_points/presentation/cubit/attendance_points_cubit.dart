import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../../data/repos/attendance_points_repo.dart';
import 'attendance_points_state.dart';

class AttendancePointsCubit extends Cubit<AttendancePointsState> {
  AttendancePointsCubit({required this.repo})
    : super(const AttendancePointsState.initial());
  final AttendancePointsRepo repo;

  Future<void> load({String? employeeId}) async {
    emit(const AttendancePointsState.loading());
    final results = await Future.wait([
      repo.getSummary(employeeId: employeeId),
      repo.getHistory(employeeId: employeeId),
    ]);
    final summaryResult = results[0] as ApiResult<dynamic>;
    final historyResult = results[1] as ApiResult<dynamic>;
    if (summaryResult case Failure(:final failure)) {
      emit(AttendancePointsState.error(failure.messageKey));
      return;
    }
    if (historyResult case Failure(:final failure)) {
      emit(AttendancePointsState.error(failure.messageKey));
      return;
    }
    final summary = (summaryResult as Success<dynamic>).data;
    final history = (historyResult as Success<dynamic>).data;
    emit(AttendancePointsState.success(summary: summary, history: history));
  }
}
