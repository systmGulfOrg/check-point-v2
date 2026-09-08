import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/supervisor/data/models/tasks/supervisor_update_task_status_request_body.dart';

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
