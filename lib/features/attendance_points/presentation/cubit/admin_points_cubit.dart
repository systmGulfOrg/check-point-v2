import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/attendance_points_repo.dart';
import 'admin_points_state.dart';

class AdminPointsCubit extends Cubit<AdminPointsState> {
  AdminPointsCubit({required this.pointsRepo})
    : super(const AdminPointsState.initial());

  final AttendancePointsRepo pointsRepo;

  Future<void> loadEmployees({String? search}) async {
    emit(const AdminPointsState.loading());
    final result = await pointsRepo.getAdminPointsEmployees(search: search);
    result.when(
      success: (page) => emit(AdminPointsState.loaded(page)),
      failure: (failure) => emit(AdminPointsState.error(failure.messageKey)),
    );
  }
}
