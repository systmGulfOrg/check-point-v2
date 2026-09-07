import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../admin/data/models/admin_task_model.dart';

part 'supervisor_tasks_state.freezed.dart';

@freezed
class SupervisorTasksState with _$SupervisorTasksState {
  const factory SupervisorTasksState.initial() = SupervisorTasksInitial;
  const factory SupervisorTasksState.loading() = SupervisorTasksLoading;
  const factory SupervisorTasksState.success({
    required List<AdminTaskModel> tasks,
    String? statusFilter,
  }) = SupervisorTasksSuccess;
  const factory SupervisorTasksState.actionSuccess(String message) =
      SupervisorTasksActionSuccess;
  const factory SupervisorTasksState.error(String messageKey) =
      SupervisorTasksError;
}
