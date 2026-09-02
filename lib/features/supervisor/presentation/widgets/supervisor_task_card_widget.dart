import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'supervisor_task_data.dart';

class SupervisorTaskCardWidget extends StatelessWidget {
  const SupervisorTaskCardWidget({required this.task, super.key});

  final SupervisorTaskData task;

  @override
  Widget build(BuildContext context) {
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
                  task.titleKey.tr(context: context),
                  style: AppTextStyles.font14SemiBold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: task.statusBackgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: BoxDecoration(
                        color: task.statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    vSpace(5),
                    Text(
                      task.statusKey.tr(context: context),
                      style: AppTextStyles.font12Bold.copyWith(
                        color: task.statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSpace(6),
          Text(
            task.descriptionKey.tr(context: context),
            style: AppTextStyles.font12Regular,
          ),
          hSpace(8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: task.priorityBackgroundColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  task.priorityKey.tr(context: context),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: task.priorityColor,
                  ),
                ),
              ),
              vSpace(8),
              Expanded(
                child: Text(
                  'supervisor.tasks.assignedTo'.tr(
                    context: context,
                    args: [task.assigneeKey.tr(context: context)],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
              ),
              for (final initials in task.assigneeInitials)
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 2.w),
                  child: CircleAvatar(
                    radius: 10.r,
                    backgroundColor: AppColors.softGreenBackground,
                    child: Text(
                      initials,
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.success,
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          vSpace(8),
          if (task.progress > 0) ...[
            hSpace(10),
            Row(
              children: [
                Text(
                  'supervisor.tasks.due'.tr(
                    context: context,
                    args: [task.dueDate],
                  ),
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                vSpace(10),
                Expanded(
                  child: LinearProgressIndicator(
                    value: task.progress,
                    minHeight: 3.h,
                    backgroundColor: AppColors.pageBackground,
                    color: AppColors.brandPrimary,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                vSpace(8),
                Text(
                  '${(task.progress * 100).round()}%',
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
