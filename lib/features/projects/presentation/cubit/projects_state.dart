import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/project_models.dart';

part 'projects_state.freezed.dart';

@freezed
class ProjectsState with _$ProjectsState {
  const factory ProjectsState.initial() = ProjectsStateInitial;
  const factory ProjectsState.loading() = ProjectsStateLoading;
  const factory ProjectsState.success({
    required List<ProjectModel> projects,
    String? selectedProjectId,
    @Default(<ProjectTaskModel>[]) List<ProjectTaskModel> tasks,
    @Default(<TaskAuditModel>[]) List<TaskAuditModel> audit,
  }) = ProjectsStateSuccess;
  const factory ProjectsState.error(String messageKey) = ProjectsStateError;
}
