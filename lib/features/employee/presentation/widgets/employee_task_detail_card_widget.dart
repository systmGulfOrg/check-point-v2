import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'employee_assignee_avatar_widget.dart';
import 'employee_status_badge_widget.dart';
import 'employee_task_data.dart';

class EmployeeTaskDetailCardWidget extends StatelessWidget {
  const EmployeeTaskDetailCardWidget({
    required this.task,
    super.key,
  });

  final EmployeeTaskData task;

  @override
  Widget build(BuildContext context) {
    final (priorityBg, priorityText) = switch (task.priority) {
      'Urgent' => (AppColors.softRedBackground, AppColors.error),
      'High' => (AppColors.softYellowBackground, AppColors.warningOrange),
      _ => (AppColors.softBlueBackground, AppColors.info),
    };

    return Container(
      padding: EdgeInsets.all(16.r),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: AppTextStyles.font16Bold,
                ),
              ),
              wSpace(12),
              EmployeeStatusBadgeWidget(status: task.status),
            ],
          ),
          if (task.priority != null) ...[
            hSpace(8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: priorityBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                task.priority!,
                style: AppTextStyles.font12Medium.copyWith(
                  color: priorityText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          if (task.description != null) ...[
            hSpace(8),
            Text(
              task.description!,
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          hSpace(14),
          Row(
            children: [
              Text(
                task.dueDate,
                style: AppTextStyles.font12Bold.copyWith(
                  color: task.status == 'Overdue'
                      ? AppColors.error
                      : AppColors.textSecondary,
                ),
              ),
              wSpace(12),
              if (task.progressPercentage != null) ...[
                Expanded(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: 0,
                      end: (task.progressPercentage! / 100).clamp(0.0, 1.0),
                    ),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) => ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: value,
                        backgroundColor: AppColors.border,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.brandPrimary,
                        ),
                        minHeight: 6.h,
                      ),
                    ),
                  ),
                ),
                wSpace(8),
                Text(
                  '${task.progressPercentage}%',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                wSpace(12),
              ],
              if (task.assignees.isNotEmpty)
                EmployeeAssigneeAvatarWidget(assignees: task.assignees),
            ],
          ),
        ],
      ),
    );
  }
}
