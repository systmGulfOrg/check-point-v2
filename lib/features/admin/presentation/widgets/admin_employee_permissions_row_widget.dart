import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminEmployeePermissionsRowWidget extends StatelessWidget {
  const AdminEmployeePermissionsRowWidget({
    required this.canAddAttendance,
    required this.canAddPlan,
    super.key,
  });

  final bool canAddAttendance;
  final bool canAddPlan;

  @override
  Widget build(BuildContext context) {
    if (!canAddAttendance && !canAddPlan) {
      return const SizedBox.shrink();
    }
    return Wrap(
      spacing: 6.w,
      runSpacing: 4.h,
      children: [
        if (canAddAttendance)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.softBlueBackground,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 12.r,
                  color: AppColors.info,
                ),
                vSpace(4),
                Text(
                  'admin.departments.attendancePermission'.tr(context: context),
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.info,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        if (canAddPlan)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.softGreenBackground,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.event_available_outlined,
                  size: 12.r,
                  color: AppColors.success,
                ),
                vSpace(4),
                Text(
                  'admin.departments.planPermission'.tr(context: context),
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.success,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
