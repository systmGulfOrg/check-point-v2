import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/admin_task_model.dart';

part 'admin_tasks_state.freezed.dart';

@freezed
abstract class AdminTasksState with _$AdminTasksState {
  const factory AdminTasksState.initial() = _Initial;
  const factory AdminTasksState.loading() = _Loading;
  const factory AdminTasksState.success(List<AdminTaskModel> tasks) = _Success;
  const factory AdminTasksState.actionSuccess(String message) = _ActionSuccess;
  const factory AdminTasksState.error(String messageKey) = _Error;
}
