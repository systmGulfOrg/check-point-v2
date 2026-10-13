import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'employee_work_access_state.dart';

class EmployeeWorkAccessCubit extends Cubit<EmployeeWorkAccessState> {
  EmployeeWorkAccessCubit({
    required this.attendanceRepo,
    required this.sessionStorage,
  }) : super(const EmployeeWorkAccessState.initial());

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;

  Future<void> load() async {
    emit(const EmployeeWorkAccessState.loading());
    final employeeId = await sessionStorage.readUserId();
    if (employeeId == null || employeeId.isEmpty) {
      emit(const EmployeeWorkAccessState.denied('remoteWork.accessDenied'));
      return;
    }

    final result = await attendanceRepo.getEmployeeById(employeeId);
    result.when(
      success: (data) {
        final workSystem = data.workSystem?.trim().toLowerCase();
        if (workSystem == 'remote') {
          emit(
            EmployeeWorkAccessState.allowed(
              workSystem: 'remote',
              policyId: data.remoteWorkPolicyId,
            ),
          );
          return;
        }
        if (workSystem == 'hybrid') {
          emit(
            EmployeeWorkAccessState.allowed(
              workSystem: 'hybrid',
              policyId: data.remoteWorkPolicyId,
            ),
          );
          return;
        }
        emit(const EmployeeWorkAccessState.denied('remoteWork.accessDenied'));
      },
      failure: (_) {
        emit(const EmployeeWorkAccessState.denied('remoteWork.accessDenied'));
      },
    );
  }
}
