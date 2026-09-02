import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/admin_greeting_widget.dart';
import '../widgets/admin_overview_card_widget.dart';
import '../widgets/admin_stats_grid_widget.dart';
import '../widgets/admin_top_bar_widget.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdminTopBarWidget(),
            hSpace(12),
            const AdminGreetingWidget(
              userNameKey: 'admin.dashboard.user',
              dateText: 'Monday, August 31',
            ),
            hSpace(12),
            const AdminStatsGridWidget(
              totalStaff: 4,
              presentToday: 2,
              pendingLeaves: 2,
              openTasks: 6,
            ),
            hSpace(20),
            const AdminOverviewCardWidget(
              employeesOnDuty: 2,
              totalStaff: 4,
              lateArrivals: 1,
              absences: 1,
              pendingLeaveRequests: 2,
              dateText: '2026-08-31',
            ),
          ],
        ),
      ),
    );
  }
}
