import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/admin_task_model.dart';
import '../models/supervisor_update_task_status_request_body.dart';

abstract class SupervisorTasksRepo {
  Future<ApiResult<List<AdminTaskModel>>> getTasks({int? departmentId});
  Future<ApiResult<void>> addTask(AddTaskRequestBody body);
  Future<ApiResult<void>> editTask(int id, AddTaskRequestBody body);
  Future<ApiResult<void>> deleteTask(int id);
  Future<ApiResult<void>> assignTask(AssignTaskRequestBody body);
  Future<ApiResult<void>> updateTaskStatus(
    SupervisorUpdateTaskStatusRequestBody body,
  );
}
