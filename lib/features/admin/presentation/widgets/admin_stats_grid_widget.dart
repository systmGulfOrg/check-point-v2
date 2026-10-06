import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_stat_card_widget.dart';

class AdminStatsGridWidget extends StatelessWidget {
  const AdminStatsGridWidget({
    required this.totalStaff,
    required this.presentToday,
    required this.pendingLeaves,
    this.isStaffLoading = false,
    this.isAttendanceLoading = false,
    this.isLeaveLoading = false,
    this.onTapStaff,
    this.onTapAttendance,
    this.onTapLeaves,
    this.onTapLocations,
    super.key,
  });

  final int totalStaff;
  final int presentToday;
  final int pendingLeaves;
  final bool isStaffLoading;
  final bool isAttendanceLoading;
  final bool isLeaveLoading;
  final VoidCallback? onTapStaff;
  final VoidCallback? onTapAttendance;
  final VoidCallback? onTapLeaves;
  final VoidCallback? onTapLocations;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.5,
      children: [
        AnimatedListItemWidget(
          index: 0,
          child: Skeletonizer(
            enabled: isStaffLoading,
            child: AdminStatCardWidget(
              icon: Icons.group_outlined,
              iconColor: AppColors.brandPrimary,
              iconBackgroundColor: AppColors.softBrandBackground,
              value: '$totalStaff',
              labelKey: 'admin.dashboard.totalStaff',
              onTap: onTapStaff,
            ),
          ),
        ),
        AnimatedListItemWidget(
          index: 1,
          child: Skeletonizer(
            enabled: isAttendanceLoading,
            child: AdminStatCardWidget(
              icon: Icons.access_time_rounded,
              iconColor: AppColors.success,
              iconBackgroundColor: AppColors.softGreenBackground,
              value: '$presentToday',
              labelKey: 'admin.dashboard.presentToday',
              onTap: onTapAttendance,
            ),
          ),
        ),
        AnimatedListItemWidget(
          index: 2,
          child: Skeletonizer(
            enabled: isLeaveLoading,
            child: AdminStatCardWidget(
              icon: Icons.calendar_today_rounded,
              iconColor: AppColors.warningOrange,
              iconBackgroundColor: AppColors.softYellowBackground,
              value: '$pendingLeaves',
              labelKey: 'admin.dashboard.pendingLeaves',
              onTap: onTapLeaves,
            ),
          ),
        ),
        AnimatedListItemWidget(
          index: 3,
          child: AdminStatCardWidget(
            icon: Icons.location_on_outlined,
            iconColor: AppColors.info,
            iconBackgroundColor: AppColors.softBlueBackground,
            value: '📍',
            labelKey: 'admin.manage.locations',
            onTap: onTapLocations,
          ),
        ),
      ],
    );
  }
}
