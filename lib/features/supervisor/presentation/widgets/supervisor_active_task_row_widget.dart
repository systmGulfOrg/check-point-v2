import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';

class SupervisorActiveTaskRowWidget extends StatelessWidget {
  const SupervisorActiveTaskRowWidget({required this.task, super.key});

  final AdminTaskModel task;

  @override
  Widget build(BuildContext context) {
    final title = task.title ?? 'Task';
    final assignee = task.assignedEmployeeName ?? 'Unassigned';
    final status = task.status ?? 'To Do';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                hSpace(4),
                Text(
                  assignee,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
              ],
            ),
          ),
          vSpace(8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.softBlueBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.r,
                  height: 6.r,
                  decoration: const BoxDecoration(
                    color: AppColors.info,
                    shape: BoxShape.circle,
                  ),
                ),
                vSpace(6),
                Text(
                  status.tr(context: context),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: AppColors.info,
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
