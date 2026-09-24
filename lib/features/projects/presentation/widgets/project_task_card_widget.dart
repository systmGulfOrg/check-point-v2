import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/project_models.dart';

class ProjectTaskCardWidget extends StatelessWidget {
  const ProjectTaskCardWidget({
    required this.task,
    required this.boardProject,
    required this.onTap,
    this.canManage = false,
    this.onMoveStatus,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final ProjectTaskModel task;
  final ProjectModel boardProject;
  final VoidCallback onTap;
  final bool canManage;
  final ValueChanged<String>? onMoveStatus;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  bool _isTaskDone(ProjectStatusModel status) {
    if (status.isDoneState == true) return true;
    final name = status.name.trim().toLowerCase();
    if (name == 'done' ||
        name == 'completed' ||
        name == 'مكتمل' ||
        name == 'تم' ||
        name == 'منتهي' ||
        name == 'مكتملة') {
      return true;
    }
    if (boardProject.statuses.isNotEmpty &&
        boardProject.statuses.last.id == status.id) {
      return true;
    }
    return false;
  }

  Color _priorityColor(String? priority) {
    return switch (priority?.toUpperCase()) {
      'URGENT' || 'CRITICAL' => AppColors.error,
      'HIGH' => AppColors.warning,
      'NORMAL' => AppColors.brandPrimary,
      'LOW' => AppColors.textSecondary,
      _ => AppColors.info,
    };
  }

  Color _priorityBackground(String? priority) {
    return switch (priority?.toUpperCase()) {
      'URGENT' || 'CRITICAL' => AppColors.softBrandBackground,
      'HIGH' => AppColors.infoBackground,
      'NORMAL' => AppColors.softBlueBackground,
      'LOW' => AppColors.pageBackground,
      _ => AppColors.softBlueBackground,
    };
  }

  void _toggleTaskCompletion(bool isDone, ProjectStatusModel currentStatus) {
    if (onMoveStatus == null || boardProject.statuses.isEmpty) return;

    if (!isDone) {
      // Move to done status
      final doneStatus = boardProject.statuses.firstWhere(
        _isTaskDone,
        orElse: () => boardProject.statuses.last,
      );
      if (doneStatus.id != currentStatus.id) {
        onMoveStatus!(doneStatus.id);
      }
    } else {
      // Move back to first/to-do status
      final firstStatus = boardProject.statuses.first;
      if (firstStatus.id != currentStatus.id) {
        onMoveStatus!(firstStatus.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = boardProject.statuses.firstWhere(
      (item) => item.id == task.statusId,
      orElse: () => boardProject.statuses.isNotEmpty
          ? boardProject.statuses.first
          : const ProjectStatusModel(id: '', name: ''),
    );

    final isDone = _isTaskDone(status);
    final priority = task.priority ?? 'NORMAL';

    // Due date analysis
    DateTime? dueDate;
    bool isOverdue = false;
    bool isDueToday = false;
    if (task.dueDate != null && task.dueDate!.isNotEmpty) {
      dueDate = DateTime.tryParse(task.dueDate!);
      if (dueDate != null && !isDone) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
        if (due.isBefore(today)) {
          isOverdue = true;
        } else if (due.isAtSameMomentAs(today)) {
          isDueToday = true;
        }
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDone ? AppColors.border : AppColors.border,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(14.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: Checkbox + Priority + Quick Status Badge + 3-dots Menu
              Row(
                children: [
                  // Quick Completion Toggle Button
                  InkWell(
                    onTap: canManage && onMoveStatus != null
                        ? () => _toggleTaskCompletion(isDone, status)
                        : null,
                    borderRadius: BorderRadius.circular(20.r),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(end: 8.w),
                      child: Icon(
                        isDone
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: isDone
                            ? AppColors.brandPrimary
                            : AppColors.placeholder,
                        size: 24.r,
                      ),
                    ),
                  ),

                  // Priority Chip
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: _priorityBackground(priority),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      priority,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: _priorityColor(priority),
                      ),
                    ),
                  ),
                  wSpace(6),

                  // Quick Status Chip (1-tap status selector popup menu)
                  if (canManage && onMoveStatus != null)
                    PopupMenuButton<String>(
                      tooltip: 'projects.changeStatus'.tr(context: context),
                      onSelected: (newStatusId) => onMoveStatus!(newStatusId),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      itemBuilder: (_) => boardProject.statuses
                          .map(
                            (s) => PopupMenuItem<String>(
                              value: s.id,
                              child: Row(
                                children: [
                                  Icon(
                                    s.id == status.id
                                        ? Icons.check_circle_rounded
                                        : Icons.circle_outlined,
                                    size: 16.r,
                                    color: s.id == status.id
                                        ? AppColors.brandPrimary
                                        : AppColors.textSecondary,
                                  ),
                                  wSpace(8),
                                  Text(
                                    s.name,
                                    style: AppTextStyles.font13SemiBold.copyWith(
                                      fontWeight: s.id == status.id
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDone
                              ? AppColors.softBrandBackground
                              : AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: isDone
                                ? AppColors.brandPrimary.withAlpha(50)
                                : AppColors.border,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              status.name,
                              style: AppTextStyles.font11Medium.copyWith(
                                color: isDone
                                    ? AppColors.brandPrimary
                                    : AppColors.textPrimary,
                              ),
                            ),
                            wSpace(4),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 14.r,
                              color: isDone
                                  ? AppColors.brandPrimary
                                  : AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        status.name,
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                  const Spacer(),

                  // Action Menu (Edit / Delete)
                  if (canManage)
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onSelected: (value) {
                        if (value == 'edit') {
                          onEdit?.call();
                        } else if (value == 'delete') {
                          onDelete?.call();
                        }
                      },
                      itemBuilder: (_) => [
                        if (onEdit != null)
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                  color: AppColors.textPrimary,
                                ),
                                wSpace(8),
                                Text('common.edit'.tr(context: context)),
                              ],
                            ),
                          ),
                        if (onDelete != null)
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.delete_outline,
                                  size: 18,
                                  color: AppColors.error,
                                ),
                                wSpace(8),
                                Text(
                                  'common.delete'.tr(context: context),
                                  style:
                                      const TextStyle(color: AppColors.error),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              hSpace(8),

              // Title
              Text(
                task.title,
                style: AppTextStyles.font16Bold.copyWith(
                  decoration: isDone ? TextDecoration.lineThrough : null,
                  color: isDone
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                ),
              ),

              // Description if available
              if (task.description?.isNotEmpty == true) ...[
                hSpace(4),
                Text(
                  task.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],

              // Tags row if available
              if (task.tags.isNotEmpty) ...[
                hSpace(8),
                Wrap(
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: task.tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        '#$tag',
                        style: AppTextStyles.font11Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              hSpace(10),

              // Footer: Assignees avatars + Due date (with overdue badge) + Attachments
              Row(
                children: [
                  if (task.assignees.isNotEmpty || task.assigneeIds.isNotEmpty) ...[
                    Wrap(
                      spacing: -6.w,
                      children: (task.assignees.isNotEmpty
                              ? task.assignees
                              : task.assigneeIds
                                  .map((id) => TaskAssigneeModel(employeeId: id)))
                          .take(4)
                          .map((assignee) {
                        final name = assignee.employeeName?.trim().isNotEmpty == true
                            ? assignee.employeeName!.trim()
                            : (assignee.employeeId ?? '?');
                        final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
                        final hasImage =
                            assignee.employeeImageUrl?.isNotEmpty == true;

                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 1.5,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 11.r,
                            backgroundColor: AppColors.brandPrimary,
                            backgroundImage: hasImage
                                ? NetworkImage(assignee.employeeImageUrl!)
                                : null,
                            child: hasImage
                                ? null
                                : Text(
                                    initial,
                                    style: AppTextStyles.font10Bold.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                          ),
                        );
                      }).toList(),
                    ),
                    wSpace(10),
                  ],

                  // Smart Due Date Indicator
                  if (task.dueDate?.isNotEmpty == true) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: isOverdue
                            ? AppColors.softBrandBackground
                            : isDueToday
                                ? AppColors.infoBackground
                                : AppColors.transparent,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isOverdue
                                ? Icons.warning_amber_rounded
                                : Icons.calendar_today_outlined,
                            size: 13.r,
                            color: isOverdue
                                ? AppColors.error
                                : isDueToday
                                    ? AppColors.warning
                                    : AppColors.textSecondary,
                          ),
                          wSpace(4),
                          Text(
                            isOverdue
                                ? '${AppDateFormatter.formatDateString(task.dueDate)} (${'projects.overdue'.tr(context: context)})'
                                : isDueToday
                                    ? 'projects.today'.tr(context: context)
                                    : AppDateFormatter.formatDateString(
                                        task.dueDate,
                                      ),
                            style: AppTextStyles.font11Medium.copyWith(
                              color: isOverdue
                                  ? AppColors.error
                                  : isDueToday
                                      ? AppColors.warning
                                      : AppColors.textSecondary,
                              fontWeight: (isOverdue || isDueToday)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    wSpace(8),
                  ],

                  const Spacer(),

                  if (task.attachments.isNotEmpty) ...[
                    Icon(
                      Icons.attach_file_rounded,
                      size: 14.r,
                      color: AppColors.textSecondary,
                    ),
                    wSpace(2),
                    Text(
                      '${task.attachments.length}',
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
