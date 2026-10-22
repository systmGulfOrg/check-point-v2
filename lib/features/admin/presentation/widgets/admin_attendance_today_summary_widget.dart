import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';

class AdminAttendanceTodaySummaryWidget extends StatelessWidget {
  const AdminAttendanceTodaySummaryWidget({
    required this.presentCount,
    required this.lateCount,
    required this.absentCount,
    required this.onLeaveCount,
    required this.onTapPresent,
    required this.onTapLate,
    required this.onTapAbsent,
    required this.onTapOnLeave,
    this.isLoading = false,
    super.key,
  });

  final int presentCount;
  final int lateCount;
  final int absentCount;
  final int onLeaveCount;
  final VoidCallback onTapPresent;
  final VoidCallback onTapLate;
  final VoidCallback onTapAbsent;
  final VoidCallback onTapOnLeave;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _AttendanceSummaryTileWidget(
                    count: presentCount,
                    labelKey: 'admin.attendance.presentToday',
                    icon: Icons.check_circle_outline_rounded,
                    color: AppColors.success,
                    backgroundColor: AppColors.softGreenBackground,
                    isLoading: isLoading,
                    onTap: onTapPresent,
                  ),
                ),
                wSpace(10),
                Expanded(
                  child: _AttendanceSummaryTileWidget(
                    count: lateCount,
                    labelKey: 'admin.attendance.lateToday',
                    icon: Icons.schedule_rounded,
                    color: AppColors.warning,
                    backgroundColor: AppColors.softYellowBackground,
                    isLoading: isLoading,
                    onTap: onTapLate,
                  ),
                ),
              ],
            ),
            hSpace(10),
            Row(
              children: [
                Expanded(
                  child: _AttendanceSummaryTileWidget(
                    count: absentCount,
                    labelKey: 'admin.attendance.absentToday',
                    icon: Icons.person_off_outlined,
                    color: AppColors.error,
                    backgroundColor: AppColors.softRedBackground,
                    isLoading: isLoading,
                    onTap: onTapAbsent,
                  ),
                ),
                wSpace(10),
                Expanded(
                  child: _AttendanceSummaryTileWidget(
                    count: onLeaveCount,
                    labelKey: 'admin.attendance.onLeaveToday',
                    icon: Icons.beach_access_outlined,
                    color: AppColors.brandPrimary,
                    backgroundColor: AppColors.softBrandBackground,
                    isLoading: isLoading,
                    onTap: onTapOnLeave,
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

class _AttendanceSummaryTileWidget extends StatelessWidget {
  const _AttendanceSummaryTileWidget({
    required this.count,
    required this.labelKey,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.isLoading,
    this.onTap,
  });

  final int count;
  final String labelKey;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final bool isLoading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Icon(icon, color: color, size: 18.r),
          ),
          wSpace(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      isLoading ? '00' : '$count',
                      style: AppTextStyles.font16Bold.copyWith(color: color),
                    ),
                    if (!isLoading && onTap != null) ...[
                      wSpace(4),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10.r,
                        color: color,
                      ),
                    ],
                  ],
                ),
                Text(
                  labelKey.tr(context: context),
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
