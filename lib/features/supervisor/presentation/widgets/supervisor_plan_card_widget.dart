import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';

class SupervisorPlanCardWidget extends StatelessWidget {
  const SupervisorPlanCardWidget({
    required this.plan,
    super.key,
    this.onDelete,
  });

  final AdminPlanModel plan;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final title = plan.title ?? 'Plan';
    final description = plan.description ?? '';
    final assignee = plan.assignedEmployeeName ?? 'Unassigned';
    final start = AppDateFormatter.formatDateString(plan.startDate);
    final end = AppDateFormatter.formatDateString(plan.endDate);
    final dateRange = (start != '-' && end != '-')
        ? '$start – $end'
        : (start != '-' ? start : '');

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 19.r,
            backgroundColor: AppColors.softBlueBackground,
            child: Icon(
              Icons.map_outlined,
              color: AppColors.brandPrimary,
              size: 20.r,
            ),
          ),
          wSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title, style: AppTextStyles.font14SemiBold),
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
                if (dateRange.trim().isNotEmpty) ...[
                  hSpace(4),
                  Text(
                    dateRange,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
                if (description.isNotEmpty) ...[
                  hSpace(4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font12Regular,
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
          ),
        ],
      ),
    );
  }
}
