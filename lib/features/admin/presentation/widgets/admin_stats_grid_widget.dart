import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/animated_list_item_widget.dart';
import 'admin_stat_card_widget.dart';

class AdminStatsGridWidget extends StatelessWidget {
  const AdminStatsGridWidget({
    required this.totalStaff,
    required this.presentToday,
    required this.pendingLeaves,
    required this.openTasks,
    super.key,
  });

  final int totalStaff;
  final int presentToday;
  final int pendingLeaves;
  final int openTasks;

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
          child: AdminStatCardWidget(
            icon: Icons.group_outlined,
            iconColor: AppColors.brandPrimary,
            iconBackgroundColor: AppColors.softBrandBackground,
            value: '$totalStaff',
            labelKey: 'admin.dashboard.totalStaff',
          ),
        ),
        AnimatedListItemWidget(
          index: 1,
          child: AdminStatCardWidget(
            icon: Icons.access_time_rounded,
            iconColor: AppColors.success,
            iconBackgroundColor: AppColors.softGreenBackground,
            value: '$presentToday',
            labelKey: 'admin.dashboard.presentToday',
          ),
        ),
        AnimatedListItemWidget(
          index: 2,
          child: AdminStatCardWidget(
            icon: Icons.calendar_today_rounded,
            iconColor: AppColors.warningOrange,
            iconBackgroundColor: AppColors.softYellowBackground,
            value: '$pendingLeaves',
            labelKey: 'admin.dashboard.pendingLeaves',
          ),
        ),
        AnimatedListItemWidget(
          index: 3,
          child: AdminStatCardWidget(
            icon: Icons.assignment_outlined,
            iconColor: AppColors.info,
            iconBackgroundColor: AppColors.softBlueBackground,
            value: '$openTasks',
            labelKey: 'admin.dashboard.openTasks',
          ),
        ),
      ],
    );
  }
}
