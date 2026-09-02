import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../admin/presentation/widgets/admin_greeting_widget.dart';
import '../../../admin/presentation/widgets/admin_stats_grid_widget.dart';
import '../../../admin/presentation/widgets/admin_top_bar_widget.dart';
import '../widgets/supervisor_active_tasks_widget.dart';
import '../widgets/supervisor_alert_banner_widget.dart';
import '../widgets/supervisor_team_today_widget.dart';

class SupervisorHomeScreen extends StatelessWidget {
  const SupervisorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdminTopBarWidget(),
            hSpace(20),
            const AdminGreetingWidget(
              greetingKey: 'supervisor.dashboard.greeting',
              userNameKey: 'supervisor.dashboard.user',
              dateText: 'Monday, August 31',
            ),
            hSpace(20),
            const SupervisorAlertBannerWidget(
              messageKey: 'supervisor.dashboard.alertPending',
            ),
            hSpace(20),
            const AdminStatsGridWidget(
              totalStaff: 3,
              presentToday: 1,
              pendingLeaves: 1,
              openTasks: 6,
            ),
            hSpace(20),
            const SupervisorTeamTodayWidget(),
            hSpace(20),
            const SupervisorActiveTasksWidget(),
          ],
        ),
      ),
    );
  }
}
