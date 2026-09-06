import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../data/repos/admin_attendance_repo.dart';
import 'admin_attendance_state.dart';

class AdminAttendanceCubit extends Cubit<AdminAttendanceState> {
  AdminAttendanceCubit({required this.attendanceRepo})
    : super(const AdminAttendanceState.initial());

  final AdminAttendanceRepo attendanceRepo;

  Future<void> loadAttendance() async {
    emit(const AdminAttendanceState.loading());
    final result = await attendanceRepo.getAdminAttendance();
    switch (result) {
      case Success(:final data):
        emit(AdminAttendanceState.success(data));
      case Failure(:final failure):
        emit(AdminAttendanceState.error(failure.messageKey));
    }
  }

  Future<bool> deleteAttendance(int id) async {
    emit(const AdminAttendanceState.loading());
    final result = await attendanceRepo.deleteAttendance(id);
    switch (result) {
      case Success():
        await loadAttendance();
        emit(
          const AdminAttendanceState.actionSuccess(
            'Attendance record deleted successfully',
          ),
        );
        return true;
      case Failure(:final failure):
        emit(AdminAttendanceState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
