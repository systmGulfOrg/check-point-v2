import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/supervisor/data/apis/supervisor_api_service.dart';
import 'package:check_point_v2/features/supervisor/data/models/tasks/supervisor_update_task_status_request_body.dart';
import 'supervisor_tasks_repo.dart';

class SupervisorTasksRepoImpl implements SupervisorTasksRepo {
  SupervisorTasksRepoImpl({required this.api, required this.sessionStorage});
  final SupervisorApiService api;
  final AuthSessionStorage sessionStorage;

  Future<int?> _resolveDepartmentId(int? departmentId) async {
    if (departmentId != null) return departmentId;
    final cached = await sessionStorage.readDepartmentId();
    if (cached != null) return cached;
    final userId = await sessionStorage.readUserId();
    if (userId != null && userId.isNotEmpty) {
      try {
        final empRes = await api.getEmployeeById(userId);
        final id = empRes.value?.departmentId;
        if (id != null) {
          await sessionStorage.saveDepartmentId(id);
          return id;
        }
      } catch (_) {}
    }
    return null;
  }

  @override
  Future<ApiResult<List<AdminTaskModel>>> getTasks({int? departmentId}) async {
    try {
      final deptId = await _resolveDepartmentId(departmentId);
      final response = deptId != null
          ? await api.getTasksByDepartment(deptId)
          : await api.getTasks();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addTask(AddTaskRequestBody body) async {
    try {
      final deptId = body.departmentId ?? await _resolveDepartmentId(null);
      final requestBody = body.departmentId == null && deptId != null
          ? AddTaskRequestBody(
              title: body.title,
              description: body.description,
              assignedEmployeeId: body.assignedEmployeeId,
              dueDate: body.dueDate,
              priorityStatus: body.priorityStatus,
              status: body.status,
              departmentId: deptId,
            )
          : body;
      await api.addTask(requestBody);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> editTask(int id, AddTaskRequestBody body) async {
    try {
      await api.editTask(id, body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteTask(int id) async {
    try {
      await api.deleteTask(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> assignTask(AssignTaskRequestBody body) async {
    try {
      await api.assignTask(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> updateTaskStatus(
    SupervisorUpdateTaskStatusRequestBody body,
  ) async {
    try {
      await api.updateTaskStatus(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
