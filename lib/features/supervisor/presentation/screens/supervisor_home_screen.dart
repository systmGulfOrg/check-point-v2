import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_greeting_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_top_bar_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_active_tasks_bloc_builder_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_alert_banner_bloc_builder_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_stats_grid_bloc_builder_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_team_today_bloc_builder_widget.dart';

class SupervisorHomeScreen extends StatelessWidget {
  const SupervisorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formattedDate = AppDateFormatter.formatFullDate(DateTime.now());

    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.brandPrimary,
        onRefresh: () => Future.wait([
          context.read<SupervisorAttendanceCubit>().loadAttendance(),
          context.read<SupervisorPlansCubit>().loadPlans(),
          context.read<SupervisorTasksCubit>().loadTasks(),
          context.read<SupervisorTeamCubit>().loadTeam(),
        ]),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
      ),
    );
  }
}
