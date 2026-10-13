import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/admin_points_employee_model.dart';
import 'profile_points_badge_widget.dart';

class AdminPointsEmployeeCardWidget extends StatelessWidget {
  const AdminPointsEmployeeCardWidget({
    required this.employee,
    required this.onTap,
    super.key,
  });

  final AdminPointsEmployeeModel employee;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final name = employee.name?.trim().isNotEmpty == true
        ? employee.name!.trim()
        : 'admin.points.unknownEmployee'.tr(context: context);
    final initials = AppImageProvider.getInitials(name);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppAvatarWidget(
                  name: name,
                  initials: initials,
                  radius: 24.r,
                  enablePreview: false,
                ),
                wSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.font14Bold,
                      ),
                      if (employee.position?.isNotEmpty == true)
                        Text(
                          employee.position!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font11Regular,
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_left_rounded,
                  color: AppColors.placeholder,
                  size: 22.r,
                ),
              ],
            ),
            hSpace(12),
            Row(
              children: [
                ProfilePointsBadgeWidget(
                  tier: employee.level.tier,
                  points: employee.level.currentPoints,
                ),
                const Spacer(),
                Text(
                  employee.department?.name ??
                      'admin.points.noDepartment'.tr(context: context),
                  style: AppTextStyles.font11Regular,
                ),
              ],
            ),
            hSpace(12),
            Wrap(
              spacing: 8.w,
              runSpacing: 6.h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                AdminPointsMetricWidget(
                  label: 'points.greenConfirmed',
                  value: employee.balances.greenConfirmed,
                  color: AppColors.success,
                ),
                AdminPointsMetricWidget(
                  label: 'points.red',
                  value: employee.balances.red,
                  color: AppColors.error,
                ),
                AdminPointsMetricWidget(
                  label: 'points.black',
                  value: employee.balances.black,
                  color: AppColors.textPrimary,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.warningOrange.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department_rounded,
                        size: 16.r,
                        color: AppColors.warningOrange,
                      ),
                      wSpace(3),
                      Text(
                        '${employee.streak.currentStreak}',
                        style: AppTextStyles.font12Bold.copyWith(
                          color: AppColors.warningOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AdminPointsMetricWidget extends StatelessWidget {
  const AdminPointsMetricWidget({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '$value ${label.tr(context: context)}',
        style: AppTextStyles.font10Bold.copyWith(color: color),
      ),
    );
  }
}
