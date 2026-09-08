import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';

part 'employee_tasks_state.freezed.dart';

@freezed
class EmployeeTasksState with _$EmployeeTasksState {
  const factory EmployeeTasksState.initial() = EmployeeTasksStateInitial;
  const factory EmployeeTasksState.loading() = EmployeeTasksStateLoading;
  const factory EmployeeTasksState.success(List<AdminTaskModel> tasks) =
      EmployeeTasksStateSuccess;
  const factory EmployeeTasksState.actionSuccess(String message) =
      EmployeeTasksStateActionSuccess;
  const factory EmployeeTasksState.error(String messageKey) =
      EmployeeTasksStateError;
}
