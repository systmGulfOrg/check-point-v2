import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import '../../data/repos/attendance_points_repo.dart';
import 'admin_points_state.dart';

class AdminPointsCubit extends SafeCubit<AdminPointsState> {
  AdminPointsCubit({required this.pointsRepo})
    : super(const AdminPointsState.initial());

  final AttendancePointsRepo pointsRepo;

  Future<void> loadEmployees({String? search}) async {
    emit(const AdminPointsState.loading());
    final result = await pointsRepo.getAdminPointsEmployees(search: search);
    result.when(
      success: (page) => safeEmit(AdminPointsState.loaded(page)),
      failure: (failure) =>
          safeEmit(AdminPointsState.error(failure.messageKey)),
    );
  }
}
