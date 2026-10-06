import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';

class SupervisorTaskCardWidget extends StatelessWidget {
  const SupervisorTaskCardWidget({
    required this.task,
    super.key,
    this.onEdit,
    this.onDelete,
    this.onStatusToggle,
  });

  final AdminTaskModel task;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onStatusToggle;

  @override
  Widget build(BuildContext context) {
    final title = task.title ?? 'Task';
    final description = task.description ?? '';
    final assignee = task.assignedEmployeeName ?? '-';
    final status = task.status ?? 'Pending';
    final priority = task.priorityStatus ?? 'Low';
    final isDone =
        status.toLowerCase() == 'completed' || status.toLowerCase() == 'done';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font16Bold.copyWith(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  hSpace(4),
                  Text(
                    description,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                hSpace(8),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: switch (priority.toLowerCase()) {
                          'critical' || 'high' => AppColors.softRedBackground,
                          'medium' => AppColors.softYellowBackground,
                          _ => AppColors.softBlueBackground,
                        },
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'supervisor.tasks.priority.${priority.toLowerCase()}'
                            .tr(context: context),
                        style: AppTextStyles.font12Medium.copyWith(
                          color: switch (priority.toLowerCase()) {
                            'critical' || 'high' => AppColors.error,
                            'medium' => AppColors.warningOrange,
                            _ => AppColors.info,
                          },
                        ),
                      ),
                    ),
                    Text(
                      task.dueDate == null
                          ? 'tasks.noDueDate'.tr(context: context)
                          : '${'supervisor.tasks.due'.tr(context: context)} '
                                '${AppDateFormatter.formatDateString(task.dueDate, pattern: 'dd MMM yyyy')}',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: task.isOverdue == true
                            ? AppColors.error
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                hSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'supervisor.tasks.assignedTo'.tr(
                        context: context,
                        args: [assignee],
                      ),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    InkWell(
                      onTap: onStatusToggle,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDone
                              ? AppColors.softGreenBackground
                              : AppColors.selectedBackground,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          status,
                          style: AppTextStyles.font12Bold.copyWith(
                            color: isDone
                                ? AppColors.success
                                : AppColors.brandPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (onEdit != null || onDelete != null)
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onEdit,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        alignment: Alignment.center,
                        child: Text(
                          'admin.locations.edit'.tr(context: context),
                          style: AppTextStyles.font13SemiBold.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 1.w, height: 24.h, color: AppColors.border),
                  Expanded(
                    child: InkWell(
                      onTap: onDelete,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        alignment: Alignment.center,
                        child: Text(
                          'admin.locations.delete'.tr(context: context),
                          style: AppTextStyles.font13SemiBold.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
