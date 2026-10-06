import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_models.dart';
import '../cubit/projects_cubit.dart';
import '../cubit/projects_state.dart';
import '../widgets/project_add_status_sheet_widget.dart';
import '../widgets/project_task_card_widget.dart';
import '../widgets/project_task_detail_sheet_widget.dart';
import '../widgets/project_task_editor_sheet_widget.dart';

class ProjectDragData {
  const ProjectDragData({this.taskId, this.sourceStatusId, this.statusId});

  final String? taskId;
  final String? sourceStatusId;
  final String? statusId;
}

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
      final descMatch =
          task.description?.toLowerCase().contains(query) ?? false;
      final tagMatch = task.tags.any(
        (tag) => tag.toLowerCase().contains(query),
      );
      final assigneeMatch = task.assigneeIds.any(
        (a) => a.toLowerCase().contains(query),
      );
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
                              icon: const Icon(
                                Icons.add_task_rounded,
                                size: 18,
                              ),
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
                    ? _buildListView(
                        context,
                        cubit,
                        boardProject,
                        tasks,
                        allTasks,
                      )
                    : _buildKanbanView(context, cubit, boardProject, tasks),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectModel boardProject,
    List<ProjectTaskModel> tasks,
    List<ProjectTaskModel> allTasks,
  ) {
    final statuses = boardProject.statuses;
    if (statuses.isEmpty) {
      return Center(child: Text('projects.empty'.tr(context: context)));
    }

    final allTabLabel = 'common.all'.tr(context: context);

    return DefaultTabController(
      key: ValueKey('${boardProject.id}_${statuses.length}'),
      length: statuses.length + 1,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            labelColor: AppColors.brandPrimary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.brandPrimary,
            tabs: [
              Tab(text: '$allTabLabel (${tasks.length})'),
              ...statuses.map((status) {
                final count = tasks
                    .where((t) => t.statusId == status.id)
                    .length;
                return Tab(text: '${status.name} ($count)');
              }),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTasksList(context, cubit, boardProject, tasks),
                ...statuses.map((status) {
                  final filtered = tasks
                      .where((t) => t.statusId == status.id)
                      .toList();
                  return _buildTasksList(
                    context,
                    cubit,
                    boardProject,
                    filtered,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectModel boardProject,
    List<ProjectTaskModel> tasksList,
  ) {
    if (tasksList.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.assignment_outlined,
                size: 48.r,
                color: AppColors.placeholder,
              ),
              hSpace(10),
              Text(
                'projects.noTasks'.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      itemCount: tasksList.length,
      itemBuilder: (context, index) {
        final task = tasksList[index];
        return ProjectTaskCardWidget(
          task: task,
          boardProject: boardProject,
          canManage: canManage,
          onTap: () => _showTaskDetails(context, cubit, task),
          onMoveStatus: (statusId) => cubit.moveTask(task.id, statusId),
          onEdit: () => _editTask(context, cubit, task),
          onDelete: () => _confirmDeleteTask(context, cubit, task),
        );
      },
    );
  }

  Widget _buildKanbanView(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectModel boardProject,
    List<ProjectTaskModel> tasks,
  ) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      itemCount: boardProject.statuses.length,
      itemBuilder: (context, statusIndex) {
        final status = boardProject.statuses[statusIndex];
        final columnTasks = tasks
            .where((task) => task.statusId == status.id)
            .toList();
        final isHovered = hoveredStatusId == status.id;

        return DragTarget<ProjectDragData>(
          onWillAcceptWithDetails: (details) {
            if (!canManage) return false;
            setState(() => hoveredStatusId = status.id);
            return details.data.taskId != null ||
                details.data.statusId != status.id;
          },
          onLeave: (_) => setState(() => hoveredStatusId = null),
          onAcceptWithDetails: (details) {
            setState(() {
              hoveredStatusId = null;
              draggingTaskId = null;
              draggingStatusId = null;
            });
            final data = details.data;
            if (data.taskId != null && data.sourceStatusId != status.id) {
              cubit.moveTask(data.taskId!, status.id);
            } else if (data.statusId != null && data.statusId != status.id) {
              final ids = boardProject.statuses.map((item) => item.id).toList();
              final fromIndex = ids.indexOf(data.statusId!);
              if (fromIndex >= 0) {
                ids.removeAt(fromIndex);
                ids.insert(statusIndex, data.statusId!);
                cubit.reorderStatuses(project.id, ids);
              }
            }
          },
          builder: (context, candidates, rejected) => AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: 280.w,
            margin: EdgeInsetsDirectional.only(end: 12.w),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.softBrandBackground
                  : AppColors.pageBackground,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isHovered ? AppColors.brandPrimary : AppColors.border,
                width: isHovered ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: const BoxDecoration(
                        color: AppColors.brandPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    wSpace(8),
                    Expanded(
                      child: Text(status.name, style: AppTextStyles.font14Bold),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        '${columnTasks.length}',
                        style: AppTextStyles.font12Bold,
                      ),
                    ),
                  ],
                ),
                hSpace(12),
                Expanded(
                  child: columnTasks.isEmpty
                      ? Center(
                          child: Text(
                            'projects.noTasks'.tr(context: context),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: columnTasks.length,
                          itemBuilder: (context, index) {
                            final task = columnTasks[index];
                            return ProjectTaskCardWidget(
                              task: task,
                              boardProject: boardProject,
                              canManage: canManage,
                              onTap: () =>
                                  _showTaskDetails(context, cubit, task),
                              onMoveStatus: (statusId) =>
                                  cubit.moveTask(task.id, statusId),
                              onEdit: () => _editTask(context, cubit, task),
                              onDelete: () =>
                                  _confirmDeleteTask(context, cubit, task),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
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
    final assigneeOptions = tasks
        .expand((task) => task.assigneeIds)
        .toSet()
        .toList();
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
