import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/admin_api_service.dart';
import '../models/admin_task_model.dart';
import 'admin_tasks_repo.dart';

class AdminTasksRepoImpl implements AdminTasksRepo {
  AdminTasksRepoImpl({required this.api});
  final AdminApiService api;

  @override
  Future<ApiResult<List<AdminTaskModel>>> getTasks() async {
    try {
      final response = await api.getTasks();
      return ApiResult.success(response.value?.list ?? []);
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
