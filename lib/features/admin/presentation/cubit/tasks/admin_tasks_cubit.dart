import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_tasks_repo.dart';
import 'admin_tasks_state.dart';

class AdminTasksCubit extends Cubit<AdminTasksState> {
  AdminTasksCubit({required this.tasksRepo})
    : super(const AdminTasksState.initial());

  final AdminTasksRepo tasksRepo;

  Future<void> loadTasks({int? departmentId, String? employeeId}) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.getTasks(
      departmentId: departmentId,
      employeeId: employeeId,
    );
    result.when(
      success: (data) => emit(AdminTasksState.success(data)),
      failure: (failure) => emit(AdminTasksState.error(failure.messageKey)),
    );
  }

  Future<bool> addTask(AddTaskRequestBody body) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.addTask(body);
    return result.when(
      success: (_) async {
        await loadTasks();
        return true;
      },
      failure: (failure) {
        emit(AdminTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> editTask(int id, AddTaskRequestBody body) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.editTask(id: id, body: body);
    return result.when(
      success: (_) async {
        await loadTasks();
        return true;
      },
      failure: (failure) {
        emit(AdminTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deleteTask(int id) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.deleteTask(id);
    return result.when(
      success: (_) async {
        await loadTasks();
        return true;
      },
      failure: (failure) {
        emit(AdminTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> assignTask(AssignTaskRequestBody body) async {
    emit(const AdminTasksState.loading());
    final result = await tasksRepo.assignTask(body);
    return result.when(
      success: (_) async {
        await loadTasks();
        return true;
      },
      failure: (failure) {
        emit(AdminTasksState.error(failure.messageKey));
        return false;
      },
    );
  }
}
