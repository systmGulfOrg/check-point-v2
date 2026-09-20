import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/project_models.dart';
import '../../data/repos/projects_repo.dart';
import 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit({required this.repo}) : super(const ProjectsState.initial());
  final ProjectsRepo repo;

  Future<void> loadProjects() async {
    emit(const ProjectsState.loading());
    final result = await repo.getProjects();
    result.when(
      success: (projects) => emit(ProjectsState.success(projects: projects)),
      failure: (failure) => emit(ProjectsState.error(failure.messageKey)),
    );
  }

  Future<void> createProject(Map<String, dynamic> body) async {
    final result = await repo.createProject(body);
    result.when(
      success: (_) => loadProjects(),
      failure: (failure) => emit(ProjectsState.error(failure.messageKey)),
    );
  }

  Future<void> openProject(ProjectModel project) async {
    final current = state;
    if (current is! ProjectsStateSuccess) return;
    emit(
      ProjectsState.success(
        projects: current.projects,
        selectedProjectId: project.id,
        tasks: current.tasks,
      ),
    );
    final result = await repo.getTasks(project.id);
    result.when(
      success: (tasks) => emit(
        ProjectsState.success(
          projects: current.projects,
          selectedProjectId: project.id,
          tasks: tasks,
        ),
      ),
      failure: (failure) => emit(ProjectsState.error(failure.messageKey)),
    );
  }

  Future<void> addStatus(String projectId, String name) async {
    final result = await repo.createStatus(projectId, name);
    result.when(
      success: (status) {
        final current = state;
        if (current is! ProjectsStateSuccess) return;
        final projects = current.projects
            .map(
              (project) => project.id == projectId
                  ? project.copyWith(statuses: [...project.statuses, status])
                  : project,
            )
            .toList();
        emit(
          ProjectsState.success(
            projects: projects,
            selectedProjectId: current.selectedProjectId,
            tasks: current.tasks,
            audit: current.audit,
          ),
        );
      },
      failure: (f) => emit(ProjectsState.error(f.messageKey)),
    );
  }

  Future<void> reorderStatuses(String projectId, List<String> ids) async {
    final result = await repo.reorderStatuses(projectId, ids);
    result.when(
      success: (_) {
        final current = state;
        if (current is! ProjectsStateSuccess) return;
        final project = current.projects.firstWhere(
          (item) => item.id == projectId,
        );
        final byId = {for (final status in project.statuses) status.id: status};
        final orderedStatuses = ids
            .map((id) => byId[id])
            .whereType<ProjectStatusModel>()
            .toList();
        final projects = current.projects
            .map(
              (item) => item.id == projectId
                  ? item.copyWith(statuses: orderedStatuses)
                  : item,
            )
            .toList();
        emit(
          ProjectsState.success(
            projects: projects,
            selectedProjectId: current.selectedProjectId,
            tasks: current.tasks,
            audit: current.audit,
          ),
        );
      },
      failure: (f) => emit(ProjectsState.error(f.messageKey)),
    );
  }

  Future<void> createTask(String projectId, Map<String, dynamic> body) async {
    final result = await repo.createTask(projectId, body);
    result.when(
      success: (_) => openProject(_project(projectId)),
      failure: (f) => emit(ProjectsState.error(f.messageKey)),
    );
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> body) async {
    final result = await repo.updateTask(taskId, body);
    result.when(
      success: (_) => _reloadSelected(),
      failure: (f) => emit(ProjectsState.error(f.messageKey)),
    );
  }

  Future<void> loadTaskAudit(String taskId) async {
    final result = await repo.getTaskAudit(taskId);
    final current = state;
    result.when(
      success: (audit) {
        if (current is ProjectsStateSuccess) {
          emit(
            ProjectsState.success(
              projects: current.projects,
              selectedProjectId: current.selectedProjectId,
              tasks: current.tasks,
              audit: audit,
            ),
          );
        }
      },
      failure: (_) {},
    );
  }

  Future<void> updateTaskTags(String taskId, List<String> tags) async {
    final result = await repo.updateTaskTags(taskId, tags);
    result.when(
      success: (_) => _reloadSelected(),
      failure: (failure) => emit(ProjectsState.error(failure.messageKey)),
    );
  }

  Future<void> moveTask(String taskId, String statusId) async {
    final result = await repo.updateTaskStatus(taskId, statusId);
    result.when(
      success: (_) => _reloadSelected(),
      failure: (f) => emit(ProjectsState.error(f.messageKey)),
    );
  }

  Future<void> assignTask(String taskId, List<String> employeeIds) async {
    final result = await repo.assignTask(taskId, employeeIds);
    result.when(
      success: (_) => _reloadSelected(),
      failure: (f) => emit(ProjectsState.error(f.messageKey)),
    );
  }

  Future<void> deleteTask(String taskId) async {
    final result = await repo.deleteTask(taskId);
    result.when(
      success: (_) => _reloadSelected(),
      failure: (f) => emit(ProjectsState.error(f.messageKey)),
    );
  }

  Future<void> uploadAttachment(String taskId, File file) =>
      repo.uploadAttachment(taskId, file);

  ProjectModel _project(String id) {
    final current = state;
    if (current is ProjectsStateSuccess) {
      return current.projects.firstWhere((p) => p.id == id);
    }
    throw StateError('Project is not loaded');
  }

  Future<void> _reloadSelected() async {
    final current = state;
    if (current is ProjectsStateSuccess && current.selectedProjectId != null) {
      await openProject(_project(current.selectedProjectId!));
    }
  }
}
