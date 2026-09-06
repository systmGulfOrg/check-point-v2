import '../../../../core/network/api_result.dart';
import '../models/admin_task_model.dart';

abstract class AdminTasksRepo {
  Future<ApiResult<List<AdminTaskModel>>> getTasks();
  Future<ApiResult<void>> addTask(AddTaskRequestBody body);
  Future<ApiResult<void>> editTask({
    required int id,
    required AddTaskRequestBody body,
  });
  Future<ApiResult<void>> deleteTask(int id);
  Future<ApiResult<void>> assignTask(AssignTaskRequestBody body);
}
