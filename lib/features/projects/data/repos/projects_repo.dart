import 'dart:io';

import 'package:check_point_v2/core/network/api_result.dart';
import '../models/project_models.dart';

abstract class ProjectsRepo {
  Future<ApiResult<List<ProjectModel>>> getProjects();
  Future<ApiResult<ProjectModel>> createProject(Map<String, dynamic> body);
  Future<ApiResult<ProjectModel>> updateProject(
    String id,
    Map<String, dynamic> body,
  );
  Future<ApiResult<void>> deleteProject(String id);
  Future<ApiResult<ProjectStatusModel>> createStatus(
    String projectId,
    String name,
  );
  Future<ApiResult<void>> reorderStatuses(
    String projectId,
    List<String> statusIds,
  );
  Future<ApiResult<List<ProjectTaskModel>>> getTasks(String projectId);
  Future<ApiResult<ProjectTaskModel>> createTask(
    String projectId,
    Map<String, dynamic> body,
  );
  Future<ApiResult<ProjectTaskModel>> updateTask(
    String taskId,
    Map<String, dynamic> body,
  );
  Future<ApiResult<List<TaskAuditModel>>> getTaskAudit(String taskId);
  Future<ApiResult<void>> updateTaskTags(String taskId, List<String> tags);
  Future<ApiResult<void>> deleteTask(String taskId);
  Future<ApiResult<void>> updateTaskStatus(String taskId, String statusId);
  Future<ApiResult<void>> assignTask(String taskId, List<String> employeeIds);
  Future<ApiResult<void>> uploadAttachment(String taskId, File file);
}
