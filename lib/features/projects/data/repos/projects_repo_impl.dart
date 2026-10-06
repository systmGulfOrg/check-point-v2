import 'dart:io';

import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../apis/projects_api_service.dart';
import '../models/project_models.dart';
import 'projects_repo.dart';

class ProjectsRepoImpl implements ProjectsRepo {
  ProjectsRepoImpl({required this.api});
  final ProjectsApiService api;

  Map<String, dynamic> _envelope(Object response) =>
      (response as Map).cast<String, dynamic>();

  List<Map<String, dynamic>> _items(Object response) {
    final value = _envelope(response)['value'];
    final raw = value is Map ? value['items'] : value;
    return raw is List
        ? raw
              .whereType<Map>()
              .map((item) => item.cast<String, dynamic>())
              .toList()
        : const [];
  }

  Map<String, dynamic> _value(Object response) {
    final value = _envelope(response)['value'];
    return value is Map ? value.cast<String, dynamic>() : <String, dynamic>{};
  }

  @override
  Future<ApiResult<List<ProjectModel>>> getProjects() async {
    try {
      return ApiResult.success(
        _items(await api.getProjects()).map(ProjectModel.fromJson).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ProjectModel>> createProject(
    Map<String, dynamic> body,
  ) async {
    try {
      return ApiResult.success(
        ProjectModel.fromJson(_value(await api.createProject(body))),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ProjectModel>> updateProject(
    String id,
    Map<String, dynamic> body,
  ) async {
    try {
      return ApiResult.success(
        ProjectModel.fromJson(_value(await api.updateProject(id, body))),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteProject(String id) =>
      _run(() => api.deleteProject(id));

  @override
  Future<ApiResult<ProjectStatusModel>> createStatus(
    String projectId,
    String name,
  ) async {
    try {
      return ApiResult.success(
        ProjectStatusModel.fromJson(
          _value(await api.createStatus(projectId, {'name': name})),
        ),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> reorderStatuses(
    String projectId,
    List<String> statusIds,
  ) => _run(() => api.reorderStatuses(projectId, {'statusIds': statusIds}));

  @override
  Future<ApiResult<List<ProjectTaskModel>>> getTasks(String projectId) async {
    try {
      return ApiResult.success(
        _items(
          await api.getTasks(projectId),
        ).map(ProjectTaskModel.fromJson).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ProjectTaskModel>> createTask(
    String projectId,
    Map<String, dynamic> body,
  ) async {
    try {
      return ApiResult.success(
        ProjectTaskModel.fromJson(
          _value(await api.createTask(projectId, body)),
        ),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<ProjectTaskModel>> updateTask(
    String taskId,
    Map<String, dynamic> body,
  ) async {
    try {
      return ApiResult.success(
        ProjectTaskModel.fromJson(_value(await api.updateTask(taskId, body))),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<TaskAuditModel>>> getTaskAudit(String taskId) async {
    try {
      return ApiResult.success(
        _items(
          await api.getTaskAudit(taskId),
        ).map(TaskAuditModel.fromJson).toList(),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> updateTaskTags(String taskId, List<String> tags) =>
      _run(() => api.updateTaskTags(taskId, {'tags': tags}));

  @override
  Future<ApiResult<void>> deleteTask(String taskId) =>
      _run(() => api.deleteTask(taskId));

  @override
  Future<ApiResult<void>> updateTaskStatus(String taskId, String statusId) =>
      _run(() => api.updateTaskStatus(taskId, {'statusId': statusId}));

  @override
  Future<ApiResult<void>> assignTask(String taskId, List<String> employeeIds) =>
      _run(
        () => api.assignTask(taskId, {
          'assigneeIds': employeeIds,
          'employeeIds': employeeIds,
        }),
      );

  @override
  Future<ApiResult<void>> uploadAttachment(String taskId, File file) =>
      _run(() => api.uploadAttachment(taskId, file));

  Future<ApiResult<void>> _run(Future<Object?> Function() action) async {
    try {
      await action();
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
