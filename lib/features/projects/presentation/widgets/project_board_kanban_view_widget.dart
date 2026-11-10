import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/projects/data/models/project_drag_data.dart';
import 'package:check_point_v2/features/projects/data/models/project_models.dart';
import 'package:check_point_v2/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:check_point_v2/features/projects/presentation/widgets/project_task_card_widget.dart';

class ProjectBoardKanbanViewWidget extends StatefulWidget {
  const ProjectBoardKanbanViewWidget({
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
  State<ProjectBoardKanbanViewWidget> createState() =>
      _ProjectBoardKanbanViewWidgetState();
}

class _ProjectBoardKanbanViewWidgetState
    extends State<ProjectBoardKanbanViewWidget> {
  String? _hoveredStatusId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      itemCount: widget.boardProject.statuses.length,
      itemBuilder: (context, statusIndex) {
        final status = widget.boardProject.statuses[statusIndex];
        final columnTasks = widget.tasks
            .where((task) => task.statusId == status.id)
            .toList();
        final isHovered = _hoveredStatusId == status.id;

        return DragTarget<ProjectDragData>(
          onWillAcceptWithDetails: (details) {
            if (!widget.canManage) return false;
            setState(() => _hoveredStatusId = status.id);
            return details.data.taskId != null ||
                details.data.statusId != status.id;
          },
          onLeave: (_) => setState(() => _hoveredStatusId = null),
          onAcceptWithDetails: (details) {
            setState(() => _hoveredStatusId = null);
            final data = details.data;
            if (data.taskId != null && data.sourceStatusId != status.id) {
              widget.cubit.moveTask(data.taskId!, status.id);
            } else if (data.statusId != null && data.statusId != status.id) {
              final ids = widget.boardProject.statuses
                  .map((item) => item.id)
                  .toList();
              final fromIndex = ids.indexOf(data.statusId!);
              if (fromIndex >= 0) {
                ids.removeAt(fromIndex);
                ids.insert(statusIndex, data.statusId!);
                widget.cubit.reorderStatuses(widget.boardProject.id, ids);
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
                              boardProject: widget.boardProject,
                              canManage: widget.canManage,
                              onTap: () => widget.onTaskTap(task),
                              onMoveStatus: (statusId) =>
                                  widget.cubit.moveTask(task.id, statusId),
                              onEdit: () => widget.onEditTask(task),
                              onDelete: () => widget.onDeleteTask(task),
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
