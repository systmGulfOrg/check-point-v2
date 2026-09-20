import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'projects_api_service.g.dart';

@RestApi()
abstract class ProjectsApiService {
  factory ProjectsApiService(Dio dio, {String? baseUrl}) = _ProjectsApiService;

  @GET('/api/v2/projects')
  Future<dynamic> getProjects();

  @POST('/api/v2/projects')
  Future<dynamic> createProject(@Body() Map<String, dynamic> body);

  @POST('/api/v2/projects/{id}/statuses')
  Future<dynamic> createStatus(
    @Path('id') String projectId,
    @Body() Map<String, dynamic> body,
  );

  @PUT('/api/v2/projects/{projectId}/statuses/reorder')
  Future<dynamic> reorderStatuses(
    @Path('projectId') String projectId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/v2/projects/{id}/tasks')
  Future<dynamic> getTasks(@Path('id') String projectId);

  @POST('/api/v2/projects/{id}/tasks')
  Future<dynamic> createTask(
    @Path('id') String projectId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/api/v2/tasks/{id}')
  Future<dynamic> updateTask(
    @Path('id') String taskId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/v2/tasks/{id}/audit')
  Future<dynamic> getTaskAudit(@Path('id') String taskId);

  @PUT('/api/v2/tasks/{id}/tags')
  Future<dynamic> updateTaskTags(
    @Path('id') String taskId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/api/v2/tasks/{id}')
  Future<dynamic> deleteTask(@Path('id') String taskId);

  @PATCH('/api/v2/tasks/{taskId}/status')
  Future<dynamic> updateTaskStatus(
    @Path('taskId') String taskId,
    @Body() Map<String, dynamic> body,
  );

  @PUT('/api/v2/tasks/{taskId}/assignees')
  Future<dynamic> assignTask(
    @Path('taskId') String taskId,
    @Body() Map<String, dynamic> body,
  );

  @MultiPart()
  @POST('/api/v2/tasks/{taskId}/attachments')
  Future<dynamic> uploadAttachment(
    @Path('taskId') String taskId,
    @Part(name: 'file') File file,
  );
}
