import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_models.dart';
import 'project_task_card_widget.dart';

class ProjectBoardTasksListWidget extends StatelessWidget {
  const ProjectBoardTasksListWidget({
    required this.tasksList,
    required this.boardProject,
    required this.canManage,
    required this.onTaskTap,
    required this.onMoveStatus,
    required this.onEditTask,
    required this.onDeleteTask,
    super.key,
  });

  final List<ProjectTaskModel> tasksList;
  final ProjectModel boardProject;
  final bool canManage;
  final ValueChanged<ProjectTaskModel> onTaskTap;
  final void Function(ProjectTaskModel task, String statusId) onMoveStatus;
  final ValueChanged<ProjectTaskModel> onEditTask;
  final ValueChanged<ProjectTaskModel> onDeleteTask;

  @override
  Widget build(BuildContext context) {
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
          onTap: () => onTaskTap(task),
          onMoveStatus: (statusId) => onMoveStatus(task, statusId),
          onEdit: () => onEditTask(task),
          onDelete: () => onDeleteTask(task),
        );
      },
    );
  }
}
