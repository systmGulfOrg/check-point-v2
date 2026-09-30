import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_models.dart';
import '../cubit/projects_cubit.dart';
import '../cubit/projects_state.dart';
import '../widgets/project_add_status_sheet_widget.dart';
import '../widgets/project_board_kanban_view_widget.dart';
import '../widgets/project_board_list_view_widget.dart';
import '../widgets/project_task_detail_sheet_widget.dart';
import '../widgets/project_task_editor_sheet_widget.dart';

class ProjectBoardScreen extends StatefulWidget {
  const ProjectBoardScreen({
    required this.project,
    this.canManage = false,
    super.key,
  });

  final ProjectModel project;
  final bool canManage;

  @override
  State<ProjectBoardScreen> createState() => _ProjectBoardScreenState();
}

class _ProjectBoardScreenState extends State<ProjectBoardScreen> {
  bool isListView = true;
  String? draggingTaskId;
  String? draggingStatusId;
  String? hoveredStatusId;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  ProjectModel get project => widget.project;
  bool get canManage => widget.canManage;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ProjectTaskModel> _filterTasks(List<ProjectTaskModel> tasks) {
    if (_searchQuery.trim().isEmpty) return tasks;
    final query = _searchQuery.trim().toLowerCase();
    return tasks.where((task) {
      final titleMatch = task.title.toLowerCase().contains(query);
      final descMatch = task.description?.toLowerCase().contains(query) ?? false;
      final tagMatch = task.tags.any((tag) => tag.toLowerCase().contains(query));
      final assigneeMatch =
          task.assigneeIds.any((a) => a.toLowerCase().contains(query));
      return titleMatch || descMatch || tagMatch || assigneeMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProjectsCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(project.name, style: AppTextStyles.font18Bold),
        actions: [
          IconButton(
            tooltip: isListView ? 'Kanban View' : 'List View',
            icon: Icon(
              isListView
                  ? Icons.view_kanban_outlined
                  : Icons.format_list_bulleted_rounded,
              color: AppColors.brandPrimary,
            ),
            onPressed: () => setState(() => isListView = !isListView),
          ),
        ],
      ),
      body: BlocBuilder<ProjectsCubit, ProjectsState>(
        builder: (context, state) {
          final allTasks = state is ProjectsStateSuccess
              ? state.tasks
              : const <ProjectTaskModel>[];
          final boardProject = state is ProjectsStateSuccess
              ? state.projects.firstWhere(
                  (item) => item.id == project.id,
                  orElse: () => project,
                )
              : project;

          final tasks = _filterTasks(allTasks);

          return Column(
            children: [
              // Search & Quick Action Header
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
                child: Column(
                  children: [
                    // Search Bar
                    CustomTextFormField(
                      hintText: 'projects.searchTasksHint'.tr(context: context),
                      controller: _searchController,
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                      onChanged: (val) => setState(() => _searchQuery = val),
                    ),

                    if (canManage) ...[
                      hSpace(8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _addStatus(context, cubit),
                              icon: const Icon(Icons.add_rounded, size: 18),
                              label: Text(
                                'projects.addStatus'.tr(context: context),
                                style: AppTextStyles.font13SemiBold,
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.textPrimary,
                                side: const BorderSide(color: AppColors.border),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                              ),
                            ),
                          ),
                          wSpace(10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  _createTask(context, cubit, allTasks),
                              icon: const Icon(Icons.add_task_rounded, size: 18),
                              label: Text(
                                'projects.addTaskButton'.tr(context: context),
                                style: AppTextStyles.font13Bold.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.brandPrimary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Board Content
              Expanded(
                child: isListView
                    ? ProjectBoardListViewWidget(
                        boardProject: boardProject,
                        tasks: tasks,
                        canManage: canManage,
                        onTaskTap: (task) => _showTaskDetails(context, cubit, task),
                        onMoveStatus: (task, statusId) =>
                            cubit.moveTask(task.id, statusId),
                        onEditTask: (task) => _editTask(context, cubit, task),
                        onDeleteTask: (task) =>
                            _confirmDeleteTask(context, cubit, task),
                      )
                    : ProjectBoardKanbanViewWidget(
                        boardProject: boardProject,
                        tasks: tasks,
                        canManage: canManage,
                        hoveredStatusId: hoveredStatusId,
                        onHoveredStatusChanged: (val) =>
                            setState(() => hoveredStatusId = val),
                        onAcceptDrag: (data, targetStatusId, statusIndex) {
                          setState(() {
                            hoveredStatusId = null;
                            draggingTaskId = null;
                            draggingStatusId = null;
                          });
                          if (data.taskId != null &&
                              data.sourceStatusId != targetStatusId) {
                            cubit.moveTask(data.taskId!, targetStatusId);
                          } else if (data.statusId != null &&
                              data.statusId != targetStatusId) {
                            final ids = boardProject.statuses
                                .map((item) => item.id)
                                .toList();
                            final fromIndex = ids.indexOf(data.statusId!);
                            if (fromIndex >= 0) {
                              ids.removeAt(fromIndex);
                              ids.insert(statusIndex, data.statusId!);
                              cubit.reorderStatuses(project.id, ids);
                            }
                          }
                        },
                        onTaskTap: (task) => _showTaskDetails(context, cubit, task),
                        onMoveStatus: (task, statusId) =>
                            cubit.moveTask(task.id, statusId),
                        onEditTask: (task) => _editTask(context, cubit, task),
                        onDeleteTask: (task) =>
                            _confirmDeleteTask(context, cubit, task),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showTaskDetails(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectTaskModel task,
  ) async {
    await cubit.loadTaskAudit(task.id);
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: ProjectTaskDetailSheetWidget(
          task: task,
          project: project,
          canManage: canManage,
          onEdit: () => _editTask(context, cubit, task),
        ),
      ),
    );
  }

  Future<void> _addStatus(BuildContext context, ProjectsCubit cubit) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (_) => ProjectAddStatusSheetWidget(
        onSave: (statusName) => cubit.addStatus(project.id, statusName),
      ),
    );
  }

  Future<void> _createTask(
    BuildContext context,
    ProjectsCubit cubit,
    List<ProjectTaskModel> tasks,
  ) async {
    final assigneeOptions =
        tasks.expand((task) => task.assigneeIds).toSet().toList();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ProjectTaskEditorSheetWidget(
        project: project,
        assigneeOptions: assigneeOptions,
        onSave: ({required body, required assigneeIds, required tags}) {
          cubit.createTask(project.id, body);
        },
      ),
    );
  }

  Future<void> _editTask(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectTaskModel task,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ProjectTaskEditorSheetWidget(
        project: project,
        task: task,
        assigneeOptions: task.assigneeIds,
        onSave: ({required body, required assigneeIds, required tags}) {
          cubit.updateTask(task.id, body);
          cubit.assignTask(task.id, assigneeIds);
          cubit.updateTaskTags(task.id, tags);
        },
      ),
    );
  }

  void _confirmDeleteTask(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectTaskModel task,
  ) {
    showDialog(
      context: context,
      builder: (dialogCtx) => CustomDialogWidget(
        title: 'projects.deleteTask'.tr(context: context),
        message:
            '${'projects.confirmDeleteTask'.tr(context: context)}\n"${task.title}"',
        icon: Icons.delete_outline_rounded,
        iconColor: AppColors.error,
        iconBackgroundColor: AppColors.softBrandBackground,
        onConfirm: () {
          Navigator.pop(dialogCtx);
          cubit.deleteTask(task.id);
        },
        confirmLabel: 'common.delete'.tr(context: context),
        confirmButtonColor: AppColors.error,
        cancelLabel: 'common.cancel'.tr(context: context),
      ),
    );
  }
}
