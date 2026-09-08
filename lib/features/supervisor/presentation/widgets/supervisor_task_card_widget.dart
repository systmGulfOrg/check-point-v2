import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';

class SupervisorTaskCardWidget extends StatelessWidget {
  const SupervisorTaskCardWidget({
    required this.task,
    super.key,
    this.onStatusToggle,
    this.onDelete,
  });

  final AdminTaskModel task;
  final VoidCallback? onStatusToggle;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final title = task.title ?? 'Task';
    final description = task.description ?? '';
    final assignee = task.assignedEmployeeName ?? 'Unassigned';
    final status = task.status ?? 'To Do';
    final isDone =
        status.toLowerCase() == 'completed' || status.toLowerCase() == 'done';

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.font14SemiBold.copyWith(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              InkWell(
                onTap: onStatusToggle,
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isDone
                        ? AppColors.softGreenBackground
                        : AppColors.softBlueBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: BoxDecoration(
                          color: isDone ? AppColors.success : AppColors.info,
                          shape: BoxShape.circle,
                        ),
                      ),
                      wSpace(5),
                      Text(
                        status.tr(context: context),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: isDone ? AppColors.success : AppColors.info,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (onDelete != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: 18.r,
                    color: AppColors.error,
                  ),
                  onPressed: onDelete,
                ),
            ],
          ),
          if (description.isNotEmpty) ...[
            hSpace(6),
            Text(
              description,
              style: AppTextStyles.font12Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          hSpace(8),
          Text(
            'supervisor.tasks.assignedTo'.tr(
              context: context,
              args: [assignee],
            ),
            style: AppTextStyles.font11Medium.copyWith(
              color: AppColors.placeholder,
            ),
          ),
        ],
      ),
    );
  }
}
