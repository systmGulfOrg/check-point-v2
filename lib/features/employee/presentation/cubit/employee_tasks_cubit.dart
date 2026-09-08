import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/auth/auth_session_storage.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/employee_remove_task_request_body.dart';
import '../../data/repos/employee_action_repo.dart';
import 'employee_tasks_state.dart';

class EmployeeTasksCubit extends Cubit<EmployeeTasksState> {
  EmployeeTasksCubit({
    required this.actionRepo,
    required this.sessionStorage,
  }) : super(const EmployeeTasksState.initial());

  final EmployeeActionRepo actionRepo;
  final AuthSessionStorage sessionStorage;

  Future<void> loadMyTasks() async {
    emit(const EmployeeTasksState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final result = await actionRepo.getEmployeeTasks(employeeId);
    switch (result) {
      case Success(:final data):
        emit(EmployeeTasksState.success(data));
      case Failure(:final failure):
        emit(EmployeeTasksState.error(failure.messageKey));
    }
  }

  Future<void> updateTaskStatus(int taskId, String status) async {
    emit(const EmployeeTasksState.loading());
    final result = await actionRepo.updateTaskStatus(taskId, status);
    switch (result) {
      case Success():
        await loadMyTasks();
        emit(const EmployeeTasksState.actionSuccess('Task status updated successfully'));
      case Failure(:final failure):
        emit(EmployeeTasksState.error(failure.messageKey));
    }
  }

  Future<void> removeTask(int taskId) async {
    emit(const EmployeeTasksState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final requestBody = EmployeeRemoveTaskRequestBody(
      taskId: taskId,
      employeeId: employeeId,
    );
    final result = await actionRepo.removeTask(requestBody);
    switch (result) {
      case Success():
        await loadMyTasks();
        emit(const EmployeeTasksState.actionSuccess('Task removed successfully'));
      case Failure(:final failure):
        emit(EmployeeTasksState.error(failure.messageKey));
    }
  }
}
