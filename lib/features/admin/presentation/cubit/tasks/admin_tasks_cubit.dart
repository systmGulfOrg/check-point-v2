import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_tasks_repo.dart';
import 'admin_tasks_state.dart';

class AdminTasksCubit extends Cubit<AdminTasksState> {
  AdminTasksCubit({required this.tasksRepo})
    : super(const AdminTasksState.initial());

  final AdminTasksRepo tasksRepo;
  List<AdminTaskModel> allTasks = const [];

  Future<void> loadTasks({int? departmentId, String? employeeId}) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.getTasks(
      departmentId: departmentId,
      employeeId: employeeId,
    );
    switch (result) {
      case Success(:final data):
        allTasks = data;
        emit(AdminTasksState.success(data));
      case Failure(:final failure):
        emit(AdminTasksState.error(failure.messageKey));
    }
  }

  Future<bool> addTask(AddTaskRequestBody body) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.addTask(body);
    switch (result) {
      case Success():
        await loadTasks();
        return true;
      case Failure(:final failure):
        emit(AdminTasksState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> editTask(int id, AddTaskRequestBody body) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.editTask(id: id, body: body);
    switch (result) {
      case Success():
        await loadTasks();
        return true;
      case Failure(:final failure):
        emit(AdminTasksState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> deleteTask(int id) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.deleteTask(id);
    switch (result) {
      case Success():
        await loadTasks();
        return true;
      case Failure(:final failure):
        emit(AdminTasksState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> assignTask(AssignTaskRequestBody body) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.assignTask(body);
    switch (result) {
      case Success():
        await loadTasks();
        return true;
      case Failure(:final failure):
        emit(AdminTasksState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
