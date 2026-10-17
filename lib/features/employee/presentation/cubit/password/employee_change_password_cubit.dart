import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/features/employee/data/models/password/employee_change_password_request_body.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_action_repo.dart';
import 'employee_change_password_state.dart';

class EmployeeChangePasswordCubit
    extends SafeCubit<EmployeeChangePasswordState> {
  EmployeeChangePasswordCubit({
    required this.actionRepo,
    required this.sessionStorage,
  }) : super(const EmployeeChangePasswordState.initial());

  final EmployeeActionRepo actionRepo;
  final AuthSessionStorage sessionStorage;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(const EmployeeChangePasswordState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final requestBody = EmployeeChangePasswordRequestBody(
      employeeId: employeeId,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    final result = await actionRepo.changePassword(requestBody);
    result.when(
      success: (_) => safeEmit(const EmployeeChangePasswordState.success()),
      failure: (failure) =>
          safeEmit(EmployeeChangePasswordState.error(failure.messageKey)),
    );
  }
}
