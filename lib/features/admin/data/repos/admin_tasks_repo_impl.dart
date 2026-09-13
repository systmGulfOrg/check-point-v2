import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'admin_tasks_repo.dart';

class AdminTasksRepoImpl implements AdminTasksRepo {
  AdminTasksRepoImpl({required this.api});
  final AdminApiService api;

  @override
  Future<ApiResult<List<AdminTaskModel>>> getTasks({
    int? departmentId,
    String? employeeId,
  }) async {
    try {
      if (employeeId != null && employeeId.isNotEmpty) {
        final response = await api.getTasksByEmployee(employeeId);
        return ApiResult.success(response.value ?? []);
      }
      final response = departmentId == null
          ? await api.getTasks()
          : await api.getTasksByDepartment(departmentId);
      return ApiResult.success(response.value?.list ?? const []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> addTask(AddTaskRequestBody body) async {
    try {
      await api.addTask(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> editTask({
    required int id,
    required AddTaskRequestBody body,
  }) async {
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
}
