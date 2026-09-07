import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../admin/presentation/widgets/admin_greeting_widget.dart';
import '../../../admin/presentation/widgets/admin_top_bar_widget.dart';
import '../widgets/supervisor_active_tasks_bloc_builder_widget.dart';
import '../widgets/supervisor_alert_banner_bloc_builder_widget.dart';
import '../widgets/supervisor_stats_grid_bloc_builder_widget.dart';
import '../widgets/supervisor_team_today_bloc_builder_widget.dart';

class SupervisorHomeScreen extends StatelessWidget {
  const SupervisorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formattedDate = AppDateFormatter.formatFullDate(DateTime.now());

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdminTopBarWidget(),
            hSpace(20),
            AdminGreetingWidget(
              greetingKey: 'supervisor.dashboard.greeting',
              userNameKey: 'supervisor.dashboard.user',
              dateText: formattedDate,
            ),
            hSpace(20),
            const SupervisorAlertBannerBlocBuilderWidget(),
            hSpace(20),
            const SupervisorStatsGridBlocBuilderWidget(),
            hSpace(20),
            const SupervisorTeamTodayBlocBuilderWidget(),
            hSpace(20),
            const SupervisorActiveTasksBlocBuilderWidget(),
          ],
        ),
      ),
    );
  }
}
