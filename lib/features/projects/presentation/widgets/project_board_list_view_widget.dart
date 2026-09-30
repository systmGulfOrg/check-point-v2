import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_models.dart';
import 'project_board_tasks_list_widget.dart';

class ProjectBoardListViewWidget extends StatelessWidget {
  const ProjectBoardListViewWidget({
    required this.boardProject,
    required this.tasks,
    required this.canManage,
    required this.onTaskTap,
    required this.onMoveStatus,
    required this.onEditTask,
    required this.onDeleteTask,
    super.key,
  });

  final ProjectModel boardProject;
  final List<ProjectTaskModel> tasks;
  final bool canManage;
  final ValueChanged<ProjectTaskModel> onTaskTap;
  final void Function(ProjectTaskModel task, String statusId) onMoveStatus;
  final ValueChanged<ProjectTaskModel> onEditTask;
  final ValueChanged<ProjectTaskModel> onDeleteTask;

  @override
  Widget build(BuildContext context) {
    final statuses = boardProject.statuses;
    if (statuses.isEmpty) {
      return Center(
        child: Text('projects.empty'.tr(context: context)),
      );
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
                final count =
                    tasks.where((t) => t.statusId == status.id).length;
                return Tab(text: '${status.name} ($count)');
              }),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ProjectBoardTasksListWidget(
                  tasksList: tasks,
                  boardProject: boardProject,
                  canManage: canManage,
                  onTaskTap: onTaskTap,
                  onMoveStatus: onMoveStatus,
                  onEditTask: onEditTask,
                  onDeleteTask: onDeleteTask,
                ),
                ...statuses.map((status) {
                  final filtered =
                      tasks.where((t) => t.statusId == status.id).toList();
                  return ProjectBoardTasksListWidget(
                    tasksList: filtered,
                    boardProject: boardProject,
                    canManage: canManage,
                    onTaskTap: onTaskTap,
                    onMoveStatus: onMoveStatus,
                    onEditTask: onEditTask,
                    onDeleteTask: onDeleteTask,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
