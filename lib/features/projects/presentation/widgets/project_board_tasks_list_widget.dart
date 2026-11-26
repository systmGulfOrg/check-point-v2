import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/projects/data/models/project_models.dart';
import 'package:check_point_v2/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:check_point_v2/features/projects/presentation/widgets/project_task_card_widget.dart';

class ProjectBoardTasksListWidget extends StatelessWidget {
  const ProjectBoardTasksListWidget({
    super.key,
    required this.boardProject,
    required this.tasks,
    required this.cubit,
    required this.canManage,
    required this.onTaskTap,
    required this.onEditTask,
    required this.onDeleteTask,
  });

  final ProjectModel boardProject;
  final List<ProjectTaskModel> tasks;
  final ProjectsCubit cubit;
  final bool canManage;
  final void Function(ProjectTaskModel) onTaskTap;
  final void Function(ProjectTaskModel) onEditTask;
  final void Function(ProjectTaskModel) onDeleteTask;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
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
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ProjectTaskCardWidget(
          task: task,
          boardProject: boardProject,
          canManage: canManage,
          onTap: () => onTaskTap(task),
          onMoveStatus: (statusId) => cubit.moveTask(task.id, statusId),
          onEdit: () => onEditTask(task),
          onDelete: () => onDeleteTask(task),
        );
      },
    );
  }
}
