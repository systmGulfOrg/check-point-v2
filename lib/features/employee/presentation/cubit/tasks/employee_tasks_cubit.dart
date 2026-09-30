import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/employee/data/models/tasks/employee_remove_task_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/employee/data/models/tasks/employee_task_log_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_action_repo.dart';
import 'employee_tasks_state.dart';

class EmployeeTasksCubit extends Cubit<EmployeeTasksState> {
  EmployeeTasksCubit({required this.actionRepo, required this.sessionStorage})
    : super(const EmployeeTasksState.initial());

  final EmployeeActionRepo actionRepo;
  final AuthSessionStorage sessionStorage;

  List<AdminTaskModel> myTasks = const [];
  List<EmployeeModel> teamMembers = const [];

  Future<void> loadMyTasks() async {
    emit(const EmployeeTasksState.loading());
    final employeeId = await sessionStorage.readEmployeeId() ?? '';
    final result = await actionRepo.getEmployeeTasks(employeeId);
    switch (result) {
      case Success(:final data):
        myTasks = data;
        emit(EmployeeTasksState.success(data));
      case Failure(:final failure):
        emit(EmployeeTasksState.error(failure.messageKey));
    }
  }

  Future<void> loadTeamMembers() async {
    final employeeId = await sessionStorage.readEmployeeId();
    if (employeeId == null || employeeId.isEmpty) return;
    var departmentId = await sessionStorage.readDepartmentId();
    if (departmentId == null) {
      final profileResult = await actionRepo.getEmployeeProfile(employeeId);
      if (profileResult case Success(:final data)) {
        departmentId = data.departmentId;
        if (departmentId != null) {
          await sessionStorage.saveDepartmentId(departmentId);
        }
      }
    }
    if (departmentId == null) return;
    final profile = await actionRepo.getTeamEmployees(departmentId);
    switch (profile) {
      case Success(:final data):
        teamMembers = data.where((member) => member.id != employeeId).toList();
      case Failure():
        teamMembers = const [];
    }
  }

  Future<bool> addTask(AddTaskRequestBody body) async {
    final result = await actionRepo.addTask(body);
    return result.when(
      success: (_) async {
        await loadMyTasks();
        return true;
      },
      failure: (failure) {
        emit(EmployeeTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> editTask(int id, AddTaskRequestBody body) async {
    final result = await actionRepo.editTask(id, body);
    return result.when(
      success: (_) async {
        await loadMyTasks();
        return true;
      },
      failure: (failure) {
        emit(EmployeeTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> assignTask(AssignTaskRequestBody body) async {
    final result = await actionRepo.assignTask(body);
    return result.when(
      success: (_) async {
        await loadMyTasks();
        return true;
      },
      failure: (failure) {
        emit(EmployeeTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<ApiResult<List<EmployeeTaskLogModel>>> loadTaskLogs(String taskId) =>
      actionRepo.getTaskLogs(taskId);

  Future<void> updateTaskStatus(int taskId, String status) async {
    emit(const EmployeeTasksState.loading());
    final result = await actionRepo.updateTaskStatus(taskId, status);
    switch (result) {
      case Success():
        await loadMyTasks();
        emit(const EmployeeTasksState.actionSuccess('tasks.statusUpdated'));
      case Failure(:final failure):
        emit(EmployeeTasksState.error(failure.messageKey));
    }
  }

  Future<void> removeTask(int taskId) async {
    emit(const EmployeeTasksState.loading());
    final employeeId = await sessionStorage.readEmployeeId() ?? '';
    final requestBody = EmployeeRemoveTaskRequestBody(
      taskId: taskId,
      employeeId: employeeId,
    );
    final result = await actionRepo.removeTask(requestBody);
    switch (result) {
      case Success():
        await loadMyTasks();
        emit(const EmployeeTasksState.actionSuccess('tasks.removed'));
      case Failure(:final failure):
        emit(EmployeeTasksState.error(failure.messageKey));
    }
  }
}
