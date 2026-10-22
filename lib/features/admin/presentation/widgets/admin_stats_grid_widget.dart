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
    required this.openTasks,
    this.onLeaveToday = 0,
    this.showTasks = true,
    this.showOnLeave = false,
    this.isStaffLoading = false,
    this.isAttendanceLoading = false,
    this.isLeaveLoading = false,
    this.isTasksLoading = false,
    this.onTotalStaffTap,
    this.onPresentTodayTap,
    this.onPendingLeavesTap,
    this.onOpenTasksTap,
    this.onOnLeaveTap,
    super.key,
  });

  final int totalStaff;
  final int presentToday;
  final int pendingLeaves;
  final int openTasks;
  final int onLeaveToday;
  final bool showTasks;
  final bool showOnLeave;
  final bool isStaffLoading;
  final bool isAttendanceLoading;
  final bool isLeaveLoading;
  final bool isTasksLoading;
  final VoidCallback? onTotalStaffTap;
  final VoidCallback? onPresentTodayTap;
  final VoidCallback? onPendingLeavesTap;
  final VoidCallback? onOpenTasksTap;
  final VoidCallback? onOnLeaveTap;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      childAspectRatio: 1.18,
      children: [
        AnimatedListItemWidget(
          index: 0,
          child: Skeletonizer(
            enabled: isStaffLoading,
            child: AdminStatCardWidget(
              icon: Icons.group_outlined,
              iconColor: AppColors.warningOrange,
              iconBackgroundColor: AppColors.softYellowBackground,
              value: '$totalStaff',
              labelKey: 'admin.dashboard.totalStaff',
              onTap: onTotalStaffTap,
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
              onTap: onPresentTodayTap,
            ),
          ),
        ),
        AnimatedListItemWidget(
          index: 2,
          child: Skeletonizer(
            enabled: isLeaveLoading,
            child: AdminStatCardWidget(
              icon: Icons.error_outline_rounded,
              iconColor: AppColors.warningOrange,
              iconBackgroundColor: AppColors.softYellowBackground,
              value: '$pendingLeaves',
              labelKey: 'admin.dashboard.pendingLeaves',
              onTap: onPendingLeavesTap,
            ),
          ),
        ),
        if (showTasks)
          AnimatedListItemWidget(
            index: 3,
            child: Skeletonizer(
              enabled: isTasksLoading,
              child: AdminStatCardWidget(
                icon: Icons.assignment_outlined,
                iconColor: AppColors.info,
                iconBackgroundColor: AppColors.softBlueBackground,
                value: '$openTasks',
                labelKey: 'admin.dashboard.openTasks',
                onTap: onOpenTasksTap,
              ),
            ),
          ),
        if (showOnLeave)
          AnimatedListItemWidget(
            index: 3,
            child: Skeletonizer(
              enabled: isLeaveLoading,
              child: AdminStatCardWidget(
                icon: Icons.beach_access_outlined,
                iconColor: AppColors.info,
                iconBackgroundColor: AppColors.softBlueBackground,
                value: '$onLeaveToday',
                labelKey: 'admin.dashboard.onLeaveToday',
                onTap: onOnLeaveTap,
              ),
            ),
          ),
      ],
    );
  }
}
