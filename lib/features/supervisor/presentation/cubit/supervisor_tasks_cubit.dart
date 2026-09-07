import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../admin/data/models/admin_task_model.dart';
import '../../data/models/supervisor_update_task_status_request_body.dart';
import '../../data/repos/supervisor_tasks_repo.dart';
import 'supervisor_tasks_state.dart';

class SupervisorTasksCubit extends Cubit<SupervisorTasksState> {
  SupervisorTasksCubit({required this.tasksRepo})
    : super(const SupervisorTasksState.initial());

  final SupervisorTasksRepo tasksRepo;
  List<AdminTaskModel> allTasks = const [];
  String? statusFilter;

  Future<void> loadTasks({int? departmentId}) async {
    emit(const SupervisorTasksState.loading());
    final result = await tasksRepo.getTasks(departmentId: departmentId);
    result.when(
      success: (data) {
        allTasks = data;
        emit(
          SupervisorTasksState.success(
            tasks: _filteredTasks,
            statusFilter: statusFilter,
          ),
        );
      },
      failure: (failure) {
        emit(SupervisorTasksState.error(failure.messageKey));
      },
    );
  }

  void filterByStatus(String? status) {
    statusFilter = status;
    emit(
      SupervisorTasksState.success(
        tasks: _filteredTasks,
        statusFilter: statusFilter,
      ),
    );
  }

  List<AdminTaskModel> get _filteredTasks {
    if (statusFilter == null ||
        statusFilter!.isEmpty ||
        statusFilter == 'All') {
      return allTasks;
    }
    return allTasks
        .where(
          (t) => (t.status ?? '').toLowerCase() == statusFilter!.toLowerCase(),
        )
        .toList();
  }

  Future<bool> addTask(AddTaskRequestBody body) async {
    final result = await tasksRepo.addTask(body);
    return result.when(
      success: (_) async {
        await loadTasks();
        return true;
      },
      failure: (failure) {
        emit(SupervisorTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> editTask(int id, AddTaskRequestBody body) async {
    final result = await tasksRepo.editTask(id, body);
    return result.when(
      success: (_) async {
        await loadTasks();
        return true;
      },
      failure: (failure) {
        emit(SupervisorTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deleteTask(int id) async {
    final result = await tasksRepo.deleteTask(id);
    return result.when(
      success: (_) async {
        await loadTasks();
        return true;
      },
      failure: (failure) {
        emit(SupervisorTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> assignTask(AssignTaskRequestBody body) async {
    final result = await tasksRepo.assignTask(body);
    return result.when(
      success: (_) async {
        await loadTasks();
        return true;
      },
      failure: (failure) {
        emit(SupervisorTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> updateTaskStatus(
    SupervisorUpdateTaskStatusRequestBody body,
  ) async {
    final result = await tasksRepo.updateTaskStatus(body);
    return result.when(
      success: (_) async {
        await loadTasks();
        return true;
      },
      failure: (failure) {
        emit(SupervisorTasksState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> updateStatus(int taskId, String status) => updateTaskStatus(
    SupervisorUpdateTaskStatusRequestBody(id: taskId, status: status),
  );
}
