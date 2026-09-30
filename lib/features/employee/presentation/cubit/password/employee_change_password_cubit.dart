import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/employee/data/models/password/employee_change_password_request_body.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_action_repo.dart';
import 'employee_change_password_state.dart';

class EmployeeChangePasswordCubit extends Cubit<EmployeeChangePasswordState> {
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
    final employeeId = await sessionStorage.readEmployeeId() ?? '';
    final requestBody = EmployeeChangePasswordRequestBody(
      employeeId: employeeId,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    final result = await actionRepo.changePassword(requestBody);
    switch (result) {
      case Success():
        emit(const EmployeeChangePasswordState.success());
      case Failure(:final failure):
        emit(EmployeeChangePasswordState.error(failure.messageKey));
    }
  }
}
