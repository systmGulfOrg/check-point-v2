import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_attendance_summary_tile_widget.dart';

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
                  child: AdminAttendanceSummaryTileWidget(
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
                  child: AdminAttendanceSummaryTileWidget(
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
                  child: AdminAttendanceSummaryTileWidget(
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
                  child: AdminAttendanceSummaryTileWidget(
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
