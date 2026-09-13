import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';

abstract class AdminTasksRepo {
  Future<ApiResult<List<AdminTaskModel>>> getTasks({
    int? departmentId,
    String? employeeId,
  });
  Future<ApiResult<void>> addTask(AddTaskRequestBody body);
  Future<ApiResult<void>> editTask({
    required int id,
    required AddTaskRequestBody body,
  });
  Future<ApiResult<void>> deleteTask(int id);
  Future<ApiResult<void>> assignTask(AssignTaskRequestBody body);
}
