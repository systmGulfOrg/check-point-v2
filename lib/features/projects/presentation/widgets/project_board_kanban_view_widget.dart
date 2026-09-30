import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_drag_data.dart';
import '../../data/models/project_models.dart';
import 'project_task_card_widget.dart';

class ProjectBoardKanbanViewWidget extends StatelessWidget {
  const ProjectBoardKanbanViewWidget({
    required this.boardProject,
    required this.tasks,
    required this.canManage,
    required this.hoveredStatusId,
    required this.onHoveredStatusChanged,
    required this.onAcceptDrag,
    required this.onTaskTap,
    required this.onMoveStatus,
    required this.onEditTask,
    required this.onDeleteTask,
    super.key,
  });

  final ProjectModel boardProject;
  final List<ProjectTaskModel> tasks;
  final bool canManage;
  final String? hoveredStatusId;
  final ValueChanged<String?> onHoveredStatusChanged;
  final void Function(ProjectDragData data, String targetStatusId, int statusIndex) onAcceptDrag;
  final ValueChanged<ProjectTaskModel> onTaskTap;
  final void Function(ProjectTaskModel task, String statusId) onMoveStatus;
  final ValueChanged<ProjectTaskModel> onEditTask;
  final ValueChanged<ProjectTaskModel> onDeleteTask;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      itemCount: boardProject.statuses.length,
      itemBuilder: (context, statusIndex) {
        final status = boardProject.statuses[statusIndex];
        final columnTasks =
            tasks.where((task) => task.statusId == status.id).toList();
        final isHovered = hoveredStatusId == status.id;

        return DragTarget<ProjectDragData>(
          onWillAcceptWithDetails: (details) {
            if (!canManage) return false;
            onHoveredStatusChanged(status.id);
            return details.data.taskId != null ||
                details.data.statusId != status.id;
          },
          onLeave: (_) => onHoveredStatusChanged(null),
          onAcceptWithDetails: (details) {
            onAcceptDrag(details.data, status.id, statusIndex);
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
                      child: Text(
                        status.name,
                        style: AppTextStyles.font14Bold,
                      ),
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
                              onTap: () => onTaskTap(task),
                              onMoveStatus: (statusId) =>
                                  onMoveStatus(task, statusId),
                              onEdit: () => onEditTask(task),
                              onDelete: () => onDeleteTask(task),
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
}
